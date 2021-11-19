import 'package:equatable/equatable.dart';

class NetworkInfo extends Equatable {
  /// Bech32 human readable part
  final String bech32Hrp;

  // Optional fields
  /// Human readable chain name
  final String name;

  /// Chain icon url
  final String iconUrl;

  /// Default token denom
  final String? defaultTokenDenom;

  /// Contains the information of a generic Cosmos-based network.
  const NetworkInfo({
    required this.bech32Hrp,
    this.name = '',
    this.iconUrl = '',
    this.defaultTokenDenom,
  });

  @override
  List<Object?> get props => <dynamic>[
        bech32Hrp,
        name,
        iconUrl,
        defaultTokenDenom,
      ];

  factory NetworkInfo.fromJson(Map<String, dynamic> json) {
    return NetworkInfo(
      bech32Hrp: json['bech32_hrp'] as String,
      name: json.containsKey('name') ? json['name'] as String : '',
      iconUrl: json.containsKey('icon_url') ? json['icon_url'] as String : '',
      defaultTokenDenom: json['default_token_denom'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bech32_hrp': bech32Hrp,
        'name': name,
        'icon_url': iconUrl,
        'default_token_denom': defaultTokenDenom,
      };
}
