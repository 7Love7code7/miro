import 'package:flutter/widgets.dart';
import 'package:miro/views/widgets/generic/qr_code_scanner/qr_code_scanner_web_impl.dart';
import 'package:miro/views/widgets/generic/qr_code_scanner/types.dart';

class QrCodeCameraWeb extends StatelessWidget {
  final QrCodeCallback qrCodeCallback;
  final BoxFit fit;
  final QrScannerErrorCallback? onError;

  const QrCodeCameraWeb({
    required this.qrCodeCallback,
    this.onError,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrCodeCameraWebImpl(
      key: key,
      qrCodeCallback: qrCodeCallback,
      fit: fit,
      onError: onError,
    );
  }
}
