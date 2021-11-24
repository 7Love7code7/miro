import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

void main() {
  // @formatter:off
  String mnemonicAsString = 'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  Mnemonic mnemonic = Mnemonic(value: mnemonicAsString);
  List<int> publicKey = <int>[2, 230, 163, 243, 204, 78, 142, 181, 242, 255, 18, 127, 23, 240, 26, 81, 90, 37, 87, 1, 55, 60, 94, 73, 154, 3, 71, 10, 32, 131, 46, 111, 124];
  List<int> privateKey = <int>[158, 115, 126, 2, 208, 98, 193, 1, 114, 159, 189, 20, 131, 168, 118, 66, 223, 196, 48, 193, 71, 233, 115, 59, 192, 240, 216, 104, 85, 120, 94, 60];
  List<int> address = <int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76];
  String bech32address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
  String bech32PublicKey = 'kirapub1addwnpepqtn28u7vf68ttuhlzfl30uq629dz24cpxu79ujv6qdrs5gyr9ehhc04qw2f';
  // @formatter:on
  group('Wallet creation test', () {
    test('Should create valid wallet', () async {
      expect(
        Wallet.derive(mnemonic: mnemonic).runtimeType,
        Wallet,
      );
    });
  });

  group('Wallet options test', () {
    Wallet wallet =  Wallet.derive(mnemonic: mnemonic);
    test('Tests wallet public key creation', () async {
      expect(
        wallet.publicKey,
        publicKey,
      );
    });
    test('Tests wallet private key creation', () async {
      expect(
        wallet.privateKey,
        privateKey,
      );
    });
    test('Tests wallet address creation', () async {
      expect(
        wallet.address,
        address,
      );
    });
    test('Tests wallet bech32Address creation', () async {
      expect(
        wallet.bech32Address,
        bech32address,
      );
    });
    test('Tests wallet bech32PublicKey creation', () async {
      expect(
        wallet.bech32PublicKey,
        bech32PublicKey,
      );
    });
  });
}
