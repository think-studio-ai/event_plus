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
  final String rawData;
  final QRCodeDataType type;
}

