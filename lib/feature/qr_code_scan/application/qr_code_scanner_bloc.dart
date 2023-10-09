import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:event_plus/core/di/injector.dart';
import 'package:event_plus/feature/qr_code_scan/domain/failure/qr_code_exception.dart';
import 'package:event_plus/feature/qr_code_scan/domain/repository/qr_code_scanner_repository.dart';
import 'package:event_plus/feature/qr_code_scan/domain/value_object/qr_code_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_code_scanner_bloc.freezed.dart';

part 'qr_code_scanner_event.dart';

part 'qr_code_scanner_state.dart';

class QrCodeScannerBloc extends Bloc<QrCodeScannerEvent, QrCodeScannerState> {
  QrCodeScannerBloc({
    QRCodeScannerRepository? qrCodeScannerRepository,
  })  : _qrCodeScannerRepository =
            qrCodeScannerRepository ?? getIt<QRCodeScannerRepository>(),
        super(const QrCodeScannerState.initial()) {
    on<_StartScanning>(_startScanning);
    on<_StopScanning>(_stopScanning);
    on<_ToggleFlashLight>(_toggleFlashLight);
    on<_OnCreateQrController>(_onCreateQrController);
  }

  bool _isFlashLightOn = false;
  final QRCodeScannerRepository _qrCodeScannerRepository;

  Future<void> _startScanning(
    QrCodeScannerEvent event,
    Emitter<QrCodeScannerState> emit,
  ) async {
    emit(const QrCodeScannerState.loading(LoadingStatus.scanning));
    final result = _qrCodeScannerRepository.scanQRCode();
    try {
      result.fold(
        (l) => emit(QrCodeScannerState.error(l)),
        (r) async {
          await for (final qrCodeData in r) {
            emit(QrCodeScannerState.caputred(
              QRCodeData(type: QRCodeDataType.registration, rawData: qrCodeData),
            ));
          }
        },
      );
    } catch (e) {
      emit(QrCodeScannerState.error(
        UnknownCameraException(
          message: e.toString(),
        ),
      ));
    }
  }

  FutureOr<void> _onCreateQrController(
    _OnCreateQrController event,
    Emitter<QrCodeScannerState> emit,
  ) {
    emit(const QrCodeScannerState.loading(LoadingStatus.creating));
    _qrCodeScannerRepository.onCreateQrController(event.controller).fold(
          (l) => emit(QrCodeScannerState.error(l)),
          (r) => emit(const QrCodeScannerState.created()),
        );
  }

  Future<void> _toggleFlashLight(
    _ToggleFlashLight event,
    Emitter<QrCodeScannerState> emit,
  ) async {
    final res = await _qrCodeScannerRepository.toggleFlashLight();
    res.fold(
      (l) => emit(QrCodeScannerState.error(l)),
      (r) {
        _isFlashLightOn = !_isFlashLightOn;
        emit(QrCodeScannerState.flashlightToggled(isOn: _isFlashLightOn));
      },
    );
  }

  Future<void> _stopScanning(
    _StopScanning event,
    Emitter<QrCodeScannerState> emit,
  ) async {
    final res = await _qrCodeScannerRepository.stopScanning();
    res.fold(
      (l) => emit(QrCodeScannerState.error(l)),
      (r) => emit(const QrCodeScannerState.stoppedScan()),
    );
  }
}
