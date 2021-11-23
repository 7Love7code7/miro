import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;

class InvalidMnemonicException implements Exception {
  final dynamic message;

  InvalidMnemonicException([this.message]);
}

/// Contains information about mnemonic
///
/// Throws [InvalidMnemonicException] on creation if mnemonic is invalid
/// Throws [UnsupportedError] if the program cannot provide a cryptographically secure
/// source of random numbers,
class Mnemonic {
  /// Mnemonic as String
  final String value;

  /// Mnemonic as Array
  final List<String> array;

  /// Mnemonic seed
  Uint8List? _seed;

  /// Creates [Mnemonic] instance from mnemonic as String
  ///
  /// Throws [InvalidMnemonicException] if mnemonic is invalid
  Mnemonic({required this.value}) : array = value.split(' ') {
    if (!validate()) {
      throw InvalidMnemonicException('Invalid mnemonic ${value}');
    }
  }

  /// Creates [Mnemonic] instance from mnemonic as List
  ///
  /// Throws [InvalidMnemonicException] if mnemonic is invalid
  Mnemonic.fromArray({required this.array}) : value = array.join(' ') {
    if (!validate()) {
      throw InvalidMnemonicException('Invalid mnemonic ${value}');
    }
  }

  /// Creates a [Mnemonic] from cryptographically secure random number
  ///
  /// Random.secure() returning a cryptographically secure random generator
  /// which reads from the entropy source provided by the embedder for every generated random value.
  /// Random.secure() delegates to window.crypto.getRandomValues() in the browser
  /// and to the OS (like urandom on the server)
  ///
  /// The Crypto.getRandomValues() method lets you get cryptographically strong random values.
  /// The array given as the parameter is filled with random numbers (random in its cryptographic meaning).
  ///
  /// To guarantee enough performance, implementations are not using a truly random number generator,
  /// but they are using a pseudo-random number generator seeded with a value with enough entropy.
  /// The pseudo-random number generator algorithm (PRNG) may vary across user agents,
  /// but is suitable for cryptographic purposes. Implementations are required to use
  /// a seed with enough entropy, like a system-level entropy source.
  ///
  /// * https://stackoverflow.com/questions/11674820/how-do-i-generate-random-numbers-in-dart
  /// * https://developer.mozilla.org/en-US/docs/Web/API/Crypto/getRandomValues
  ///
  /// If the program cannot provide a cryptographically secure
  /// source of random numbers, it throws an [UnsupportedError].
  factory Mnemonic.random() {
    return Mnemonic(value: bip39.generateMnemonic(strength: 256));
  }

  /// ** HEAVY OPERATION **
  /// The operation of calculating the seed is very time consuming,
  /// therefore the seed is saved after the first calculation
  Uint8List get seed {
    _seed ??= bip39.mnemonicToSeed(value);
    return _seed!;
  }

  /// Validates mnemonic by parsing it into entropy.
  /// If the operation is successful, it returns true, otherwise false
  bool validate() {
    return bip39.validateMnemonic(value);
  }
}
