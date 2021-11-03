import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

class CoreWrapper extends StatelessWidget {
  const CoreWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
