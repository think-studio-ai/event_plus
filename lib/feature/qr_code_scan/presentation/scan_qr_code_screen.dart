import 'package:event_plus/core/di/injector.dart';
import 'package:event_plus/feature/qr_code_scan/application/qr_code_scanner_bloc.dart';
import 'package:event_plus/feature/qr_code_scan/domain/repository/qr_code_scanner_repository.dart';
import 'package:event_plus/feature/qr_code_scan/presentation/widget/qr_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const QRViewExample(),
              ),
            );
          },
          child: const Text('qrView'),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrCodeScannerBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: QrCodeView(
                    onCreateQrController: (ctrl) {
                      context
                          .read<QrCodeScannerBloc>()
                          .add(QrCodeScannerEvent.onCreateQrController(ctrl));
                      context
                          .read<QrCodeScannerBloc>()
                          .add(const QrCodeScannerEvent.startScanning());
                    },
                    onPermissionSet: (ctrl, p) =>
                        getIt<QRCodeScannerRepository>().setPermissionForCamera(
                      context: context,
                      ctrl: ctrl,
                      permission: p,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change
    // the scanArea and overlay accordingly.
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (ctrl) {
        context
            .read<QrCodeScannerBloc>()
            .add(QrCodeScannerEvent.onCreateQrController(ctrl));
        context
            .read<QrCodeScannerBloc>()
            .add(const QrCodeScannerEvent.startScanning());
      },
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => getIt<QRCodeScannerRepository>()
          .setPermissionForCamera(context: context, ctrl: ctrl, permission: p),
    );
  }
}
