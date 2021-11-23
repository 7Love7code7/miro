import 'package:equatable/equatable.dart';

// TODO(dominik): Rename to WalletDetails (name overlaps with NetworkModel), it doesn't interact INTERX with low level data transport layer
/// Contains information about a blockchain network
class NetworkInfo extends Equatable {
  /// Bech32 human readable part
  final String bech32Hrp;

  /// Human readable chain name
  final String? name;

  /// Chain icon url
  final String? iconUrl;

  /// Default token name
  final String? defaultTokenName;

  /// Contains the information of a network.
  const NetworkInfo({
    required this.bech32Hrp,
    this.name = '',
    this.iconUrl,
    this.defaultTokenName,
  });

  @override
  List<Object?> get props => <dynamic>[
        bech32Hrp,
        name,
        iconUrl,
        defaultTokenName,
      ];

  factory NetworkInfo.fromJson(Map<String, dynamic> json) {
    return NetworkInfo(
      bech32Hrp: json['bech32Hrp'] as String,
      name: json['name'] as String?,
      iconUrl: json['iconUrl'] as String?,
      defaultTokenName: json['defaultTokenName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bech32Hrp': bech32Hrp,
        'name': name,
        'iconUrl': iconUrl,
        'defaultTokenName': defaultTokenName,
      };
}
