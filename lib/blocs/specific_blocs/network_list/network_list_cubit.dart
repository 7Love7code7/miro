import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/infra/services/interx_status_service.dart';
import 'package:miro/shared/constants/network_health.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/network_status.dart';
import 'package:miro/shared/utils/assets_manager.dart';

part 'network_list_state.dart';

class NetworkListCubit extends Cubit<NetworkListState> {
  final InterxStatusService interxStatusService;
  List<NetworkModel> networkList = List<NetworkModel>.empty(growable: true);

  NetworkListCubit({required this.interxStatusService}) : super(NetworkListInitialState()) {
    getNetworks();
  }

  Future<void> getNetworks() async {
    networkList = List<NetworkModel>.empty(growable: true);
    List<NetworkModel> staticNetworks = await _fetchNetworkList();

    for (NetworkModel network in staticNetworks) {
      NetworkHealthStatus networkStatus = await _checkNetworkHealth(network);
      networkList.add(
        NetworkModel.status(
          from: network,
          status: NetworkStatus(
            status: networkStatus,
          ),
        ),
      );
    }
    emit(NetworkListLoadedState(networkList: networkList));
  }

  Future<List<NetworkModel>> _fetchNetworkList() async {
    Map<String, dynamic> json = await AssetsManager().getAsMap('assets/network_list_config.json');
    return (json['network_list'] as List<dynamic>)
        .map((dynamic e) => NetworkModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<NetworkHealthStatus> _checkNetworkHealth(NetworkModel networkModel) async =>
      await interxStatusService.getHealth(networkModel.parsedUri);
}
