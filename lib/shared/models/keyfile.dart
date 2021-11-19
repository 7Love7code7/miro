import 'dart:convert';
import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:miro/shared/models/network_info.dart';
import 'package:miro/shared/models/wallet.dart';
import 'package:miro/shared/utils/browser_utils.dart';

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

  factory KeyFile.fromFile(List<int> bytes) {
    String keyFileAsString = utf8.decode(bytes);
    Map<String, dynamic> keyFileAsJson = jsonDecode(keyFileAsString) as Map<String, dynamic>;
    return KeyFile.fromJson(keyFileAsJson);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': HEX.encode(address),
      'privateKey': HEX.encode(privateKey),
      'publicKey': HEX.encode(publicKey),
      'networkInfo': networkInfo.toJson(),
    };
  }

  List<int> toBytes() {
    final String keyFileAsString = jsonEncode(toJson());
    List<int> bytes = utf8.encode(keyFileAsString);
    return bytes;
  }

  void download() {
    BrowserUtils.download(toBytes(), 'keyfile.json');
  }
}
