
abstract class QRCodeException extends Error{

  QRCodeException({required this.message});
  final String message;
}

class CameraException extends QRCodeException {
  CameraException({required super.message});
}

