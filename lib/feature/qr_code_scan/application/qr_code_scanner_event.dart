part of 'qr_code_scanner_bloc.dart';

@freezed
sealed class QrCodeScannerEvent with _$QrCodeScannerEvent {
  const factory QrCodeScannerEvent.startScanning() = _StartScanning;

  const factory QrCodeScannerEvent.stopScanning() = _StopScanning;

  const factory QrCodeScannerEvent.toggleFlashLight() = _ToggleFlashLight;

  const factory QrCodeScannerEvent.onCreateQrController(
    QRViewController controller,
  ) = _OnCreateQrController;
}
