part of 'qr_code_scanner_bloc.dart';

enum LoadingStatus { scanning, creating }

@freezed
sealed class QrCodeScannerState with _$QrCodeScannerState {
  const factory QrCodeScannerState.initial() = _Initial;

  const factory QrCodeScannerState.scanning(QRCodeData qrCodeData) = _Scanning;

  const factory QrCodeScannerState.stoppedScan() = _StoppedScan;

  const factory QrCodeScannerState.caputred(QRCodeData qrCodeData) = _Captured;

  const factory QrCodeScannerState.loading(LoadingStatus loading) = _Loading;

  const factory QrCodeScannerState.created() = _Created;

  const factory QrCodeScannerState.error(QRCodeException error) = _Error;

  const factory QrCodeScannerState.cameraPermission({required bool granted}) =
      _CameraPermission;

  const factory QrCodeScannerState.flashlightToggled({required bool isOn}) =
      _FlashlightToggled;
}
