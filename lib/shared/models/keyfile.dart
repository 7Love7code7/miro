import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/models/network_info.dart';
import 'package:miro/shared/models/wallet.dart';
import 'package:miro/shared/utils/browser_utils.dart';
import 'package:miro/shared/utils/string_utils.dart';

class KeyFile {
  final Uint8List address;
  final Uint8List privateKey;
  final Uint8List publicKey;
  final NetworkInfo networkInfo;

  KeyFile({
    required this.address,
    required this.privateKey,
    required this.publicKey,
    required this.networkInfo,
  });

  factory KeyFile.fromWallet(Wallet wallet) {
    return KeyFile(
      address: wallet.address,
      privateKey: wallet.privateKey,
      publicKey: wallet.publicKey,
      networkInfo: wallet.networkInfo,
    );
  }

  factory KeyFile.fromJson(Map<String, dynamic> json) {
    return KeyFile(
      address: Uint8List.fromList(HEX.decode(json['address'] as String)),
      privateKey: Uint8List.fromList(HEX.decode(json['privateKey'] as String)),
      publicKey: Uint8List.fromList(HEX.decode(json['publicKey'] as String)),
      networkInfo: NetworkInfo.fromJson(json['networkInfo'] as Map<String, dynamic>),
    );
  }

  factory KeyFile.fromFile(String keyFileAsString, String password) {
    final Key key = Key.fromUtf8(StringUtils.fillFileToLength(text: password, size: 32));
    final Encrypter encrypter = Encrypter(AES(key));
    String decryptedString = encrypter.decrypt(Encrypted.fromBase64(keyFileAsString), iv: IV.fromLength(16));
    Map<String, dynamic> keyFileAsJson = jsonDecode(decryptedString) as Map<String, dynamic>;
    return KeyFile.fromJson(keyFileAsJson);
  }

  void download(String password) {
    final String keyFileAsString = jsonEncode(toJson());
    final Key key = Key.fromUtf8(StringUtils.fillFileToLength(text: password, size: 32));
    final Encrypter encrypter = Encrypter(AES(key));
    String encryptedString = encrypter.encrypt(keyFileAsString, iv: IV.fromLength(16)).base64;
    BrowserUtils.download(<String>[encryptedString], 'keyfile.json');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': HEX.encode(address),
      'privateKey': HEX.encode(privateKey),
      'publicKey': HEX.encode(publicKey),
      'networkInfo': networkInfo.toJson(),
    };
  }

  @override
  String toString() {
    return 'KeyFile{address: $address, privateKey: $privateKey, publicKey: $publicKey, networkInfo: $networkInfo}';
  }
}
