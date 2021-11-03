import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api/interx_status/interx_status.dart';
import 'package:miro/shared/models/network_status.dart';
import 'package:miro/shared/utils/network_tools.dart';

@immutable
class NetworkModel {
  final String name;
  final String url;
  final NetworkStatus status;
  final InterxStatus? interxStatus;
  final Uri parsedUri;

  bool get isConnected => interxStatus != null;

  NetworkModel({
    required this.name,
    required this.url,
    required this.status,
    this.interxStatus,
  }) : parsedUri = NetworkTools.parseUrl(url);

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json['name'] as String,
        url: json['address'] as String,
        status: NetworkStatus.offline(),
      );

  factory NetworkModel.status({required NetworkModel from, required NetworkStatus status}) => NetworkModel(
        url: from.url,
        name: from.name,
        status: status,
      );

  factory NetworkModel.connected({required NetworkModel from, required InterxStatus status}) => NetworkModel(
        url: from.url,
        name: from.name,
        status: NetworkStatus.online(),
        interxStatus: status,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkModel && runtimeType == other.runtimeType && parsedUri == other.parsedUri;

  @override
  int get hashCode => parsedUri.hashCode;

  @override
  String toString() => 'NetworkModel{name: $name, url: $url, status: $status, NetworkData: $interxStatus}';
}
