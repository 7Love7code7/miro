import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/interx_status_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appListProviders = <SingleChildWidget>[
  ChangeNotifierProvider<NetworkProvider>.value(
    value: globalLocator<NetworkProvider>(),
  ),
  ChangeNotifierProvider<WalletProvider>.value(
    value: globalLocator<WalletProvider>(),
  ),
  BlocProvider<NetworkConnectorCubit>(
    lazy: false,
    create: (BuildContext context) => NetworkConnectorCubit(
      interxStatusService: globalLocator<InterxStatusService>(),
    ),
  ),
  BlocProvider<NetworkListCubit>(
    lazy: false,
    create: (BuildContext context) => NetworkListCubit(
      interxStatusService: globalLocator<InterxStatusService>(),
    ),
  ),
];
