import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/qr_code_scanner/qr_code_scanner_web.dart';
import 'package:miro/views/widgets/generic/qr_code_scanner/types.dart';

class SaifuQrScannerDialog extends StatefulWidget {
  final QrCodeCallback qrCodeCallback;

  const SaifuQrScannerDialog({
    required this.qrCodeCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaifuQrScannerDialog();
}

class _SaifuQrScannerDialog extends State<SaifuQrScannerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
          maxHeight: 500,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Scan QR-Code from Saifu App'),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 250),
              child: QrCodeCameraWeb(
                fit: BoxFit.contain,
                qrCodeCallback: onReceiveQrCode,
                onError: (BuildContext context, Object error) {
                  print(error);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onReceiveQrCode(String scanData) {
    if (mounted) {
      context.router.pop();
      widget.qrCodeCallback(scanData);
    }
  }
}
