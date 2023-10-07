import 'package:qr_code_scanner/qr_code_scanner.dart';

enum QRCodeDataType {
  registration,
  workshop
}

/// QRCodeData is a value object that represents the data that is encoded in a QR code.
class QRCodeData {

  const QRCodeData({
    required this.rawData,
    required this.type,
  });
  final Barcode rawData;
  final QRCodeDataType type;
}

