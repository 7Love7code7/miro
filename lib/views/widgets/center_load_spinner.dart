import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterLoadSpinner extends StatelessWidget {
  const CenterLoadSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
