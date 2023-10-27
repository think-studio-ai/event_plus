import 'package:dartz/dartz.dart';
import 'package:event_plus/feature/qr_code_scan/domain/failure/qr_code_exception.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract interface class QRCodeScannerRepository {
  /// toggle flash light
  Future<Either<QRCodeException, Unit>> toggleFlashLight();

  /// Stop the QR code scanning process.
  Future<Either<QRCodeException, Unit>> stopScanning();

  /// Scan a QR code and return the scanned data as a string.
  /// return stream of scanned data
  Either<QRCodeException, Stream<Barcode>> scanQRCode();

  /// Create a QRViewController and return it.
  Either<QRCodeException, Unit> onCreateQrController(
    QRViewController controller,
  );

  /// create a dispose function for QRViewController
  Either<QRCodeException, Unit> onDisposeQrController();

  /// set permission for camera
  Either<QRCodeException, Unit> setPermissionForCamera({
    required BuildContext context,
    required QRViewController ctrl,
    required bool permission,
  });
}
