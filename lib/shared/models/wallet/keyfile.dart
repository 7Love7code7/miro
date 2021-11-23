import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/models/wallet/network_info.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/browser_utils.dart';
import 'package:miro/shared/utils/password_utils.dart';

/// Stores the content of the keyfile.json.
///
/// The keyfile is used to login into the wallet.
/// It can be downloaded or stored in the cache
/// The content of the keyfile is encrypted with the AES265 algorithm, using the user's password
class KeyFile {
  /// The wallet hex address
  final Uint8List address;

  /// The wallet hex private key
  final Uint8List privateKey;

  /// The wallet hex public key
  final Uint8List publicKey;

  /// Class containing details about the wallet network
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

  /// Creates a Keyfile instance from encrypted file content
  factory KeyFile.fromFile(String keyFileAsString, String password) {
    String decryptedKeyFile = _decryptKeyFileData(password, keyFileAsString);
    Map<String, dynamic> keyFileAsJson = jsonDecode(decryptedKeyFile) as Map<String, dynamic>;
    return KeyFile.fromJson(keyFileAsJson);
  }

  /// Encrypts the content and calls a download action
  void download(String password, {String name = 'keyfile.json'}) {
    String encryptedKeyFile = _encryptKeyFile(password);
    BrowserUtils.downloadFile(<String>[encryptedKeyFile], name);
  }

  String _encryptKeyFile(String password) {
    final String keyFileAsString = jsonEncode(toJson());
    final Key key = Key.fromUtf8(PasswordUtils.fillToLength(text: password, length: 32));
    final Encrypter crypt = Encrypter(AES(key));
    String encryptedString = crypt.encrypt(keyFileAsString, iv: IV.fromLength(16)).base64;
    return encryptedString;
  }

  static String _decryptKeyFileData(String password, String encryptedKeyFile) {
    final Key key = Key.fromUtf8(PasswordUtils.fillToLength(text: password, length: 32));
    final Encrypter crypt = Encrypter(AES(key));
    String decryptedString = crypt.decrypt(Encrypted.fromBase64(encryptedKeyFile), iv: IV.fromLength(16));
    return decryptedString;
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
