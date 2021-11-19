import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KiraQrCode extends StatelessWidget {
  final String data;
  final double size;
  final int version;

  const KiraQrCode({
    required this.data,
    this.size = 150,
    this.version = QrVersions.auto,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: data,
      version: version,
      size: size,
      gapless: true,
    );
  }
}
