import 'dart:typed_data';

// import 'package:bech32/bech32.dart' as bech32;
import 'package:bip32/bip32.dart' as bip32;
import 'package:equatable/equatable.dart';
import 'package:hex/hex.dart';
import 'package:miro/config/default_networks_list.dart';
import 'package:miro/shared/models/mnemonic.dart';
import 'package:miro/shared/models/network_info.dart';
import 'package:miro/shared/utils/bech32_encoder.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/export.dart';

/// Represents a wallet which contains the hex private key, the hex public key
/// and the hex address.
/// In order to create one properly, the [Wallet.derive] method should always
/// be used.
/// The associated [networkInfo] will be used when computing the [bech32Address]
/// associated with the wallet.
class Wallet extends Equatable {
  static const String baseDerivationPath = "m/44'/118'/0'/0";

  final Uint8List address;
  final Uint8List privateKey;
  final Uint8List publicKey;

  final NetworkInfo networkInfo;

  const Wallet({
    required this.networkInfo,
    required this.address,
    required this.privateKey,
    required this.publicKey,
  });

  @override
  List<Object> get props {
    return <Object>[networkInfo, address, privateKey, publicKey];
  }

  /// Derives the private key from the given [mnemonic]
  /// using the specified [networkInfo].
  /// Optionally can define a different derivation path
  /// setting [lastDerivationPathSegment].
  factory Wallet.derive({
    required Mnemonic mnemonic,
    NetworkInfo networkInfo = defaultNetwork,
    String lastDerivationPathSegment = '0',
  }) {
    final int _lastDerivationPathSegmentCheck = int.tryParse(lastDerivationPathSegment) ?? -1;
    if (_lastDerivationPathSegmentCheck < 0) {
      throw Exception('Invalid index format $lastDerivationPathSegment');
    }

    // Convert the mnemonic to a BIP32 instance
    final bip32.BIP32 root = bip32.BIP32.fromSeed(mnemonic.seed);

    // Get the node from the derivation path
    final bip32.BIP32 derivedNode = root.derivePath('$baseDerivationPath/$lastDerivationPathSegment');

    // Get the curve data
    final ECCurve_secp256k1 secp256k1 = ECCurve_secp256k1();
    final ECPoint point = secp256k1.G;

    // Compute the curve point associated to the private key
    final BigInt bigInt = BigInt.parse(HEX.encode(derivedNode.privateKey!), radix: 16);
    final ECPoint? curvePoint = point * bigInt;

    // Get the public key
    final Uint8List publicKeyBytes = curvePoint!.getEncoded();

    // Get the address
    final Uint8List sha256Digest = SHA256Digest().process(publicKeyBytes);
    final Uint8List address = RIPEMD160Digest().process(sha256Digest);

    return Wallet(
      address: address,
      publicKey: publicKeyBytes,
      privateKey: derivedNode.privateKey!,
      networkInfo: networkInfo,
    );
  }

  /// Creates a new [Wallet] instance based on the existent [wallet] for
  /// the given [networkInfo].
  factory Wallet.convert(Wallet wallet, NetworkInfo networkInfo) {
    return Wallet(
      networkInfo: networkInfo,
      address: wallet.address,
      privateKey: wallet.privateKey,
      publicKey: wallet.publicKey,
    );
  }

  /// Returns the associated [address] as a Bech32 string.
  String get bech32Address => Bech32Encoder.encode(networkInfo.bech32Hrp, address);

  /// Returns the associated [publicKey] as a Bech32 string
  String get bech32PublicKey {
    final List<int> type = <int>[235, 90, 233, 135, 33]; // "addwnpep"
    final String prefix = '${networkInfo.bech32Hrp}pub';
    final Uint8List fullPublicKey = Uint8List.fromList(type + publicKey);
    return Bech32Encoder.encode(prefix, fullPublicKey);
  }

  /// Returns the associated [privateKey] as an [ECPrivateKey] instance.
  ECPrivateKey get _ecPrivateKey {
    final BigInt privateKeyInt = BigInt.parse(HEX.encode(privateKey), radix: 16);
    return ECPrivateKey(privateKeyInt, ECCurve_secp256k1());
  }

  /// Returns the associated [publicKey] as an [ECPublicKey] instance.
  ECPublicKey get ecPublicKey {
    final ECCurve_secp256k1 secp256k1 = ECCurve_secp256k1();
    final ECPoint point = secp256k1.G;
    final ECPoint? curvePoint = point * _ecPrivateKey.d;
    return ECPublicKey(curvePoint, ECCurve_secp256k1());
  }

  /// Creates a new [Wallet] instance from the given [json] and [privateKey].
  factory Wallet.fromJson(Map<String, dynamic> json, Uint8List privateKey) {
    final Uint8List address = Uint8List.fromList(HEX.decode(json['hex_address'] as String));
    final Uint8List publicKey = Uint8List.fromList(HEX.decode(json['public_key'] as String));
    return Wallet(
      address: address,
      publicKey: publicKey,
      privateKey: privateKey,
      networkInfo: NetworkInfo.fromJson(json['network_info'] as Map<String, dynamic>),
    );
  }

  /// Converts the current [Wallet] instance into a JSON object.
  /// Note that the private key is not serialized for safety reasons.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'hex_address': HEX.encode(address),
        'bech32_address': bech32Address,
        'public_key': HEX.encode(publicKey),
        'network_info': networkInfo.toJson(),
      };
}
