import 'package:dartz/dartz.dart';
import 'package:event_plus/core/di/injector.dart';
import 'package:event_plus/feature/qr_code_scan/domain/failure/qr_code_exception.dart'
    as qr_code_exception;
import 'package:event_plus/feature/qr_code_scan/domain/failure/qr_code_exception.dart';
import 'package:event_plus/feature/qr_code_scan/domain/repository/qr_code_scanner_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr_code_scanner;
import 'package:qr_code_scanner/qr_code_scanner.dart';

typedef QRViewCreatedCallback = void Function(QRViewController);

@devEnvironment
@LazySingleton(as: QRCodeScannerRepository)
class QRCodeScanner implements QRCodeScannerRepository {
  late final QRViewController? _controller;

  @override
  Either<qr_code_exception.QRCodeException, Unit> onDisposeQrController() {
    try {
      _controller?.dispose();
      return right(unit);
    } on qr_code_scanner.CameraException catch (e) {
      return left(qr_code_exception.CameraException(message: e.code));
    } catch (e) {
      return left(
        qr_code_exception.UnknownCameraException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Either<QRCodeException, Stream<Barcode>> scanQRCode() {
    try {
      if (_controller == null) {
        return left(
          qr_code_exception.CameraException(
            message: 'Camera is not initialized',
          ),
        );
      }
      return right(_controller!.scannedDataStream);
    } on qr_code_scanner.CameraException catch (e) {
      return left(qr_code_exception.CameraException(message: e.code));
    } catch (e) {
      return left(
        qr_code_exception.UnknownCameraException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<qr_code_exception.QRCodeException, Unit>> stopScanning() async {
    try {
      await _controller?.pauseCamera();
      return right(unit);
    } on qr_code_scanner.CameraException catch (e) {
      return left(qr_code_exception.CameraException(message: e.code));
    } catch (e) {
      return left(
        qr_code_exception.UnknownCameraException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<qr_code_exception.QRCodeException, Unit>>
      toggleFlashLight() async {
    try {
      await _controller?.toggleFlash();
      return right(unit);
    } on qr_code_scanner.CameraException catch (e) {
      return left(qr_code_exception.CameraException(message: e.code));
    } catch (e) {
      return left(
        qr_code_exception.UnknownCameraException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Either<qr_code_exception.QRCodeException, Unit> onCreateQrController(
    QRViewController controller,
  ) {
    try {
      _controller = controller;
      return right(unit);
    } on qr_code_scanner.CameraException catch (e) {
      return left(qr_code_exception.CameraException(message: e.code));
    } catch (e) {
      return left(
        qr_code_exception.UnknownCameraException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Either<qr_code_exception.QRCodeException, Unit> setPermissionForCamera({
    required BuildContext context,
    required qr_code_scanner.QRViewController ctrl,
    required bool permission,
  }) {
    if (!permission) {
      return left(
        qr_code_exception.CameraPermissionException(
          message: 'Permission denied',
        ),
      );
    } else {
      return right(unit);
    }
  }
}
