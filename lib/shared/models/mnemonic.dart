import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;

class Mnemonic {
  final String value;
  final List<String> array;

  Mnemonic({required this.value}) : array = value.split(' ');

  Mnemonic.fromArray({required this.array}) : value = array.join(' ');

  bool validate() {
    return bip39.validateMnemonic(value);
  }

  Uint8List toSeed() {
    return bip39.mnemonicToSeed(value);
  }
}
