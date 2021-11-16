import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' show Digest, sha256;
import 'package:hex/hex.dart';

import 'utils/pbkdf2.dart';
import 'wordlists/english.dart';

const int _sizeByte = 255;
const String _invalidMnemonic = 'Invalid mnemonic';
const String _invalidEntropy = 'Invalid entropy';

typedef RandomBytes = Uint8List Function(int size);

int _binaryToByte(String binary) {
  return int.parse(binary, radix: 2);
}

String _bytesToBinary(Uint8List bytes) {
  return bytes.map((int byte) => byte.toRadixString(2).padLeft(8, '0')).join('');
}

String _deriveChecksumBits(Uint8List entropy) {
  final int ent = entropy.length * 8;
  final int cs = ent ~/ 32;
  final Digest hash = sha256.convert(entropy);
  return _bytesToBinary(Uint8List.fromList(hash.bytes)).substring(0, cs);
}

Uint8List _randomBytes(int size) {
  final Random rng = Random.secure();
  final Uint8List bytes = Uint8List(size);
  for (int i = 0; i < size; i++) {
    bytes[i] = rng.nextInt(_sizeByte);
  }
  return bytes;
}

String generateMnemonic({int strength = 128, RandomBytes randomBytes = _randomBytes}) {
  assert(strength % 32 == 0, 'Strength should be divisible by 32');
  final Uint8List entropy = randomBytes(strength ~/ 8);
  return entropyToMnemonic(HEX.encode(entropy));
}

String entropyToMnemonic(String entropyString) {
  final Uint8List entropy = Uint8List.fromList(HEX.decode(entropyString));
  if (entropy.length < 16) {
    throw ArgumentError(_invalidEntropy);
  }
  if (entropy.length > 32) {
    throw ArgumentError(_invalidEntropy);
  }
  if (entropy.length % 4 != 0) {
    throw ArgumentError(_invalidEntropy);
  }
  final String entropyBits = _bytesToBinary(entropy);
  final String checksumBits = _deriveChecksumBits(entropy);
  final String bits = entropyBits + checksumBits;
  final RegExp regex = RegExp('.{1,11}', caseSensitive: false, multiLine: false);
  final List<String> chunks =
      regex.allMatches(bits).map((RegExpMatch match) => match.group(0)!).toList(growable: false);
  List<String> wordlist = mnemonicWorldList;
  String words = chunks.map((String binary) => wordlist[_binaryToByte(binary)]).join(' ');
  return words;
}

Uint8List mnemonicToSeed(String mnemonic, {String passphrase = ''}) {
  final PBKDF2 pbkdf2 = PBKDF2();
  return pbkdf2.process(mnemonic, passphrase: passphrase);
}

String mnemonicToSeedHex(String mnemonic, {String passphrase = ''}) {
  return mnemonicToSeed(mnemonic, passphrase: passphrase).map((int byte) {
    return byte.toRadixString(16).padLeft(2, '0');
  }).join('');
}

bool validateMnemonic(String mnemonic) {
  try {
    mnemonicToEntropy(mnemonic);
  } on Exception {
    return false;
  }
  return true;
}

String mnemonicToEntropy(String mnemonic) {
  List<String> words = mnemonic.split(' ');
  if (words.length % 3 != 0) {
    throw ArgumentError(_invalidMnemonic);
  }
  const List<String> wordlist = mnemonicWorldList;
  // convert word indices to 11 bit binary strings
  final String bits = words.map((String word) {
    final int index = wordlist.indexOf(word);
    if (index == -1) {
      throw ArgumentError(_invalidMnemonic);
    }
    return index.toRadixString(2).padLeft(11, '0');
  }).join('');
  // split the binary string into ENT/CS
  final int dividerIndex = (bits.length / 33).floor() * 32;
  final String entropyBits = bits.substring(0, dividerIndex);
  final String checksumBits = bits.substring(dividerIndex);

  // calculate the checksum and compare
  final RegExp regex = RegExp('.{1,8}');
  final Uint8List entropyBytes = Uint8List.fromList(
      regex.allMatches(entropyBits).map((RegExpMatch match) => _binaryToByte(match.group(0)!)).toList(growable: false));
  if (entropyBytes.length < 16) {
    throw StateError(_invalidEntropy);
  }
  if (entropyBytes.length > 32) {
    throw StateError(_invalidEntropy);
  }
  if (entropyBytes.length % 4 != 0) {
    throw StateError(_invalidEntropy);
  }
  final String newChecksum = _deriveChecksumBits(entropyBytes);
  if (newChecksum != checksumBits) {
    throw StateError(_invalidEntropy);
  }
  return entropyBytes.map((int byte) {
    return byte.toRadixString(16).padLeft(2, '0');
  }).join('');
}
