import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;

class InvalidMnemonicException implements Exception {
  final dynamic message;

  InvalidMnemonicException([this.message]);
}

class Mnemonic {
  final String value;
  final List<String> array;
  Uint8List? _seed;

  Mnemonic({required this.value}) : array = value.split(' ') {
    if (!validate()) {
      throw InvalidMnemonicException('Invalid mnemonic ${value}');
    }
  }

  Mnemonic.fromArray({required this.array}) : value = array.join(' ') {
    if (!validate()) {
      throw InvalidMnemonicException('Invalid mnemonic ${value}');
    }
  }

  factory Mnemonic.random() {
    return Mnemonic(value: bip39.generateMnemonic(strength: 256));
  }

  Uint8List get seed {
    _seed ??= bip39.mnemonicToSeed(value);
    return _seed!;
  }

  bool validate() {
    return bip39.validateMnemonic(value);
  }
}
