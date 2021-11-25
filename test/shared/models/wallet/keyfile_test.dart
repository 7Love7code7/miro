import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

void main() {
  // @formatter:off
  String mnemonicAsString = 'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  Mnemonic mnemonic = Mnemonic(value: mnemonicAsString);
  Wallet wallet = Wallet.derive(mnemonic: mnemonic);
  // @formatter:on
  group('Keyfile creation test', () {
    test('Should create valid Keyfile instance', () async {
      expect(
        KeyFile.fromWallet(wallet).runtimeType,
        KeyFile,
      );
    });
  });

  group('Keyfile services', () {
    KeyFile testedKeyFile = KeyFile.fromWallet(wallet);
    String testPassword = 'kiraPassword';
    test('Encrypt keyfile', () async {
      expect(
        testedKeyFile.getEncryptedContent(testPassword).runtimeType,
        String,
      );
    });
    test('Decrypt keyfile', () async {
      String encryptedKeyFileString = testedKeyFile.getEncryptedContent(testPassword);
      expect(
        KeyFile.fromFile(encryptedKeyFileString, testPassword).privateKey,
        testedKeyFile.privateKey,
      );
    });
  });
}
