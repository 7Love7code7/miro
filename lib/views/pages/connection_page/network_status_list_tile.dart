import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/shared/constants/network_health.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:provider/provider.dart';

enum NetworkStatusEnum {
  connecting,
  connected,
  connectedHover,
  disconnected,
  disconnectedHover,
}

class NetworkStatusListTile extends StatefulWidget {
  final NetworkModel networkModel;

  const NetworkStatusListTile({
    required this.networkModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkStatusListTile();
}

class _NetworkStatusListTile extends State<NetworkStatusListTile> {
  NetworkStatusEnum _selectedNetworkStatus = NetworkStatusEnum.disconnected;

  @override
  void initState() {
    _setInitialItemStatus();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NetworkStatusListTile oldWidget) {
    _setInitialItemStatus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      onHover: (bool val) => _onHover(status: val),
      child: ListTile(
        title: Text(widget.networkModel.name),
        leading: _buildNetworkHealthStatusWidget(),
        trailing: _buildNetworkConnectionStatusWidget(),
      ),
    );
  }

  void _setInitialItemStatus() {
    if (widget.networkModel.isConnected) {
      _selectedNetworkStatus = NetworkStatusEnum.connected;
    } else {
      _selectedNetworkStatus = NetworkStatusEnum.disconnected;
    }
  }

  Future<void> _onTap() async {
    if (widget.networkModel.isConnected) {
      _disconnectFromNetwork();
    } else {
      await _connectToNetwork();
      unawaited(AutoRouter.of(context).push(const ValidatorsRoute()));
    }
  }

  void _onHover({required bool status}) {
    switch (_selectedNetworkStatus) {
      case NetworkStatusEnum.disconnected:
      case NetworkStatusEnum.disconnectedHover:
        _setConnectingStatus(
          status ? NetworkStatusEnum.disconnectedHover : NetworkStatusEnum.disconnected,
        );
        break;
      case NetworkStatusEnum.connected:
      case NetworkStatusEnum.connectedHover:
        _setConnectingStatus(
          status ? NetworkStatusEnum.connectedHover : NetworkStatusEnum.connected,
        );
        break;
      default:
    }
  }

  Future<void> _connectToNetwork() async {
    _setConnectingStatus(NetworkStatusEnum.connecting);
    bool status = await context.read<NetworkConnectorCubit>().connect(widget.networkModel);
    if (!status) {
      widget.networkModel.status.status = NetworkHealthStatus.offline;
    }
  }

  void _disconnectFromNetwork() {
    context.read<NetworkConnectorCubit>().disconnect();
    _setConnectingStatus(NetworkStatusEnum.disconnected);
  }

  void _setConnectingStatus(NetworkStatusEnum status) {
    setState(() {
      _selectedNetworkStatus = status;
    });
  }

  // TODO(dpajak99): After UI, move it to single widget
  Widget _buildNetworkHealthStatusWidget() {
    switch (widget.networkModel.status.status) {
      case NetworkHealthStatus.online:
        return const Icon(
          Icons.circle,
          color: Colors.green,
        );
      default:
        return const Icon(
          Icons.circle,
          color: Colors.red,
        );
    }
  }

  Widget? _buildNetworkConnectionStatusWidget() {
    switch (_selectedNetworkStatus) {
      case NetworkStatusEnum.connecting:
        return const Text('Connecting...');
      case NetworkStatusEnum.connected:
        return const Text('Connected');
      case NetworkStatusEnum.connectedHover:
        return const Text('Disconnected');
      case NetworkStatusEnum.disconnectedHover:
        return const Text('Connect');
      default:
        return null;
    }
  }
}
