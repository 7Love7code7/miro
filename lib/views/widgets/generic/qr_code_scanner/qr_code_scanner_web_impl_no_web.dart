import 'package:flutter/widgets.dart';

// ignore_for_file: no_logic_in_create_state
class QrCodeCameraWebImpl extends StatefulWidget {
  final void Function(String qrValue) qrCodeCallback;
  final Widget child;
  final BoxFit fit;
  final Widget Function(BuildContext context, Object error) onError;

  const QrCodeCameraWebImpl({
    required this.qrCodeCallback,
    required this.child,
    required this.onError,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    throw FittedBox(
      fit: fit,
      child: const Text('it is not in web environment'),
    );
  }
}
