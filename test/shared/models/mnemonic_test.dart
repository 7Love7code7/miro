import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/utils/bech32_encoder.dart';
import 'package:miro/shared/utils/password_utils.dart';

void main() {
  // @formatter:off
  String mnemonicAsString = 'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  List<int> mnemonicSeed = <int>[114, 228, 102, 104, 248, 35, 254, 120, 42, 171, 177, 56, 53, 130, 116, 125, 99, 81, 244, 100, 43, 4, 51, 199, 60, 111, 108, 251, 170, 124, 14, 95, 162, 11, 110, 6, 170, 218, 237, 5, 212, 78, 104, 118, 226, 93, 168, 47, 228, 46, 121, 70, 244, 65, 130, 14, 219, 29, 92, 223, 60, 105, 217, 163];
  // @formatter:on
  group('Mnemonic creation test', () {
    test('Should create valid mnemonic', () async {
      expect(
        Mnemonic(value: mnemonicAsString).runtimeType,
        Mnemonic,
      );
    });
    test('Should throw exception', () async {
      expect(
        () => Mnemonic(value: 'Hi am Kira network'),
        throwsA(isA<InvalidMnemonicException>()),
      );
    });
  });
  group('Mnemonic options test', () {
    Mnemonic mnemonic = Mnemonic(value: mnemonicAsString);
    test('Check mnemonic to seed', () async {
      expect(
        mnemonic.seed,
        mnemonicSeed,
      );
    });
  });
}
