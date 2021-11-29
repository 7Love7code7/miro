import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/crypto/bech32_encoder.dart';

void main() {
  group('bech32_encoder_test', () {
    String humanReadablePart = 'kira';
    // @formatter:off
    List<int> testedArray = <int>[13,41,239,196,115,78,15,223,145,175,184,1,196,71,191,112,61,105,68,97];
    // @formatter:on

    test('encode test', () async {
      expect(
        Bech32Encoder.encode(humanReadablePart, Uint8List.fromList(testedArray)),
        'kira1p557l3rnfc8alyd0hqqug3alwq7kj3rpg930y0',
      );
    });
  });
}
