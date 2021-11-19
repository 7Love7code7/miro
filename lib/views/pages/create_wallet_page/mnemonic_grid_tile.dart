import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MnemonicGridTile extends StatelessWidget {
  final String mnemonic;

  const MnemonicGridTile({
    required this.mnemonic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(mnemonic);
  }
}
