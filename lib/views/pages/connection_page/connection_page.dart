import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/network_status.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/connection_page/network_status_list_tile.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:provider/provider.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionPage();
}

class _ConnectionPage extends State<ConnectionPage> {
  final TextEditingController customNetworkTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<NetworkListCubit, NetworkListState>(
          builder: (_, NetworkListState networkListState) {
            if (networkListState is NetworkListLoadedState) {
              return Consumer<NetworkProvider>(builder: (_, NetworkProvider networkProvider, Widget? child) {
                int networkListLength = networkListState.networkList.length;
                int extraItems = 2;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: networkListLength + extraItems,
                  itemBuilder: (_, int index) {
                    if (index == networkListLength + 1) {
                      return Text('${networkProvider.currentNetwork}');
                    }
                    if (index == networkListLength) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: customNetworkTextController,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              unawaited(AutoRouter.of(context).push(const ValidatorsRoute()));
                              bool status = await context.read<NetworkConnectorCubit>().connect(
                                    NetworkModel(
                                      url: customNetworkTextController.text,
                                      name: 'custom network',
                                      status: NetworkStatus.offline(),
                                    ),
                                  );
                              if (status) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Connected'),
                                  ),
                                );
                                // customNetworkTextController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Connection error'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Connect'),
                          ),
                        ],
                      );
                    }
                    return NetworkStatusListTile(
                      networkModel: _selectNetwork(networkProvider.currentNetwork, networkListState.networkList[index]),
                    );
                  },
                );
              });
            }
            return const CenterLoadSpinner();
          },
        ),
      ),
    );
  }

  NetworkModel _selectNetwork(NetworkModel? currentNetwork, NetworkModel newNetwork) {
    if (currentNetwork != null && currentNetwork.isConnected && currentNetwork == newNetwork) {
      return NetworkModel(
        url: currentNetwork.url,
        name: newNetwork.name,
        status: currentNetwork.status,
        interxStatus: currentNetwork.interxStatus,
      );
    }
    return newNetwork;
  }
}
