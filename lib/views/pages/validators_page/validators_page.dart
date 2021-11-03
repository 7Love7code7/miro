import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:provider/provider.dart';

class ValidatorsPage extends StatelessWidget {
  const ValidatorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Consumer<NetworkProvider>(
            builder: (_, NetworkProvider networkProvider, Widget? child) {
              return Text('${networkProvider.currentNetwork}');
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NetworkConnectorCubit>().disconnect();
              AutoRouter.of(context).pop();
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
