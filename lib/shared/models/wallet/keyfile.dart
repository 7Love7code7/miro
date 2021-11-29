import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/models/wallet/network_info.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/crypto/aes_coder.dart';
import 'package:miro/shared/utils/crypto/bech32_encoder.dart';
import 'package:miro/shared/utils/password_utils.dart';

/// Stores the content of the keyfile.json.
///
/// The keyfile is used to login into the wallet.
/// It can be downloaded or stored in the cache
/// The content of the keyfile is encrypted with the AES265 algorithm, using the user's password
class KeyFile {
  /// Latest version of keyfile
  static const String latestVersion = '1.0.0';

  /// The wallet hex address
  final Uint8List address;

  /// The wallet hex private key
  final Uint8List privateKey;

  /// The wallet hex public key
  final Uint8List publicKey;

  /// Class containing details about the wallet network
  final NetworkInfo networkInfo;

  /// Version of keyfile
  final String version;

  KeyFile({
    required this.address,
    required this.privateKey,
    required this.publicKey,
    required this.networkInfo,
    required this.version,
  });

  factory KeyFile.fromWallet(Wallet wallet) {
    return KeyFile(
      address: wallet.address,
      privateKey: wallet.privateKey,
      publicKey: wallet.publicKey,
      networkInfo: wallet.networkInfo,
        version: latestVersion,
    );
  }

  factory KeyFile.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> secretData = json['secretData'] as Map<String, dynamic>;
    return KeyFile(
      version: json['version'] as String,
      address: Uint8List.fromList(HEX.decode(json['address'] as String)),
      privateKey: Uint8List.fromList(HEX.decode(secretData['privateKey'] as String)),
      publicKey: Uint8List.fromList(HEX.decode(json['publicKey'] as String)),
      networkInfo: NetworkInfo.fromJson(json['networkInfo'] as Map<String, dynamic>),
    );
  }

  /// Creates a Keyfile instance from encrypted file content
  factory KeyFile.fromFile(String keyFileAsString, String password) {
      Map<String, dynamic> keyFileAsJson = jsonDecode(keyFileAsString) as Map<String, dynamic>;
      keyFileAsJson['secretData'] = jsonDecode(AesCoder.decrypt(password, keyFileAsJson['secretData'] as String));
      return KeyFile.fromJson(keyFileAsJson);
  }

  /// Returns the associated [address] as a Bech32 string.
  String get bech32Address => Bech32Encoder.encode(networkInfo.bech32Hrp, address);

  String getFileContent(String password) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    return encoder.convert(toEncryptedJson(password));
  }

  String get fileName {
    String _address = bech32Address;
    String firstPart = _address.substring(0, 7);
    String lastPart = _address.substring(_address.length - 3, _address.length);
    return 'keyfile_${firstPart}_$lastPart.json';
  }

  Map<String, dynamic> toPublicDataJson() {
    return <String, dynamic>{
      'publicKey': HEX.encode(publicKey),
      'address': HEX.encode(address),
      'bech32Address': bech32Address,
      'networkInfo': networkInfo.toJson(),
      'version': latestVersion,
    };
  }

  Map<String, dynamic> _toPrivateDataJson() {
    return <String, dynamic>{
      'privateKey': HEX.encode(privateKey),
    };
  }

  Map<String, dynamic> toEncryptedJson(String password) {
    return <String, dynamic>{
      ...toPublicDataJson(),
      'secretData': AesCoder.encrypt(password, jsonEncode(_toPrivateDataJson()))
    };
  }

  @override
  String toString() {
    return 'KeyFile{address: $address, privateKey: $privateKey, publicKey: $publicKey, networkInfo: $networkInfo}';
  }
}
