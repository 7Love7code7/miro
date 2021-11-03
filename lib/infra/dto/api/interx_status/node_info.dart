import 'package:miro/infra/dto/api/interx_status/protocol_version.dart';

class NodeInfo {
  final String channels;
  final String id;
  final String listenAddress;
  final String moniker;
  final String network;
  final String rpcAddress;
  final String txIndex;
  final ProtocolVersion protocolVersion;
  final String version;

  NodeInfo({
    required this.channels,
    required this.id,
    required this.listenAddress,
    required this.moniker,
    required this.network,
    required this.rpcAddress,
    required this.txIndex,
    required this.protocolVersion,
    required this.version,
  });

  factory NodeInfo.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> otherData = json['other'] as Map<String, dynamic>;
    return NodeInfo(
      channels: json['channels'] as String,
      id: json['id'] as String,
      listenAddress: json['listen_addr'] as String,
      moniker: json['moniker'] as String,
      network: json['network'] as String,
      rpcAddress: otherData['rpc_address'] as String,
      txIndex: otherData['tx_index'] as String,
      protocolVersion: ProtocolVersion.fromJson(json['protocol_version'] as Map<String, dynamic>),
      version: json['version'] as String,
    );
  }
}
