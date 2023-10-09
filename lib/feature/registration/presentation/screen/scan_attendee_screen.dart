import 'package:event_plus/core/di/injector.dart';
import 'package:event_plus/feature/qr_code_scan/application/qr_code_scanner_bloc.dart';
import 'package:event_plus/feature/qr_code_scan/domain/repository/qr_code_scanner_repository.dart';
import 'package:event_plus/feature/qr_code_scan/presentation/widget/qr_code_view.dart';
import 'package:event_plus/l10n/l10n.dart';
import 'package:event_plus/util/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanAttendeeScreen extends StatelessWidget {
  const ScanAttendeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return BlocProvider(
      create: (context) => QrCodeScannerBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar:  PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(title: loc.scanAttendee),
            ),
            body: QrCodeView(
              onCreateQrController: (controller) {
                context.read<QrCodeScannerBloc>().add(
                      QrCodeScannerEvent.onCreateQrController(controller),
                    );
                context.read<QrCodeScannerBloc>().add(
                      const QrCodeScannerEvent.startScanning(),
                    );
              },
              onPermissionSet: (controller, permission) {

                getIt<QRCodeScannerRepository>()
                    .setPermissionForCamera(context, controller, permission);
              },
            ),
          );
        },
      ),
    );
  }
}
