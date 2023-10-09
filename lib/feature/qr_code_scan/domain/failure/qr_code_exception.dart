
abstract class QRCodeException extends Error{

  QRCodeException({required this.message});
  final String message;
}

class CameraException extends QRCodeException {
  CameraException({required super.message});
}

class CameraPermissionException extends QRCodeException {
  CameraPermissionException({required super.message});
}

class UnknownCameraException extends QRCodeException {
  UnknownCameraException({required super.message});
}

