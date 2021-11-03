import 'package:miro/infra/dto/api/interx_status/node.dart';
import 'package:miro/infra/dto/api/interx_status/pub_key.dart';

class InterxInfo {
  final String faucetAddress;
  final bool catchingUp;
  final String chainId;
  final String genesisChecksum;
  final String kiraAddress;
  final String kiraPubKey;
  final String latestBlockHeight;
  final String moniker;
  final Node node;
  final PubKey pubKey;
  final String version;

  InterxInfo({
    required this.faucetAddress,
    required this.catchingUp,
    required this.chainId,
    required this.genesisChecksum,
    required this.kiraAddress,
    required this.kiraPubKey,
    required this.latestBlockHeight,
    required this.moniker,
    required this.node,
    required this.pubKey,
    required this.version,
  });

  factory InterxInfo.fromJson(Map<String, dynamic> json) => InterxInfo(
        faucetAddress: json['FaucetAddr'] as String,
        catchingUp: json['catching_up'] as bool,
        chainId: json['chain_id'] as String,
        genesisChecksum: json['genesis_checksum'] as String,
        kiraAddress: json['kira_addr'] as String,
        kiraPubKey: json['kira_pub_key'] as String,
        latestBlockHeight: json['latest_block_height'] as String,
        moniker: json['moniker'] as String,
        node: Node.fromJson(json['node'] as Map<String, dynamic>),
        pubKey: PubKey.fromJson(json['pub_key'] as Map<String, dynamic>),
        version: json['version'] as String,
      );
}
