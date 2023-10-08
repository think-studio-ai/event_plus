import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeView extends StatelessWidget {
  QrCodeView({
    required this.onCreateQrController,
    required this.onPermissionSet,
    super.key,
  });

  final void Function(QRViewController) onCreateQrController;
  final void Function(QRViewController, bool)? onPermissionSet;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: onCreateQrController,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: onPermissionSet,
    );
  }
}
