import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/interx_status/interx_status.dart';
import 'package:miro/infra/services/interx_status_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/network_status.dart';
import 'package:miro/shared/utils/network_tools.dart';

part 'network_connector_state.dart';

class NetworkConnectorCubit extends Cubit<NetworkConnectorState> {
  final InterxStatusService interxStatusService;
  final NetworkProvider networkProvider = globalLocator<NetworkProvider>();

  NetworkConnectorCubit({required this.interxStatusService}) : super(NetworkConnectorInitialState()) {
    connectFromUrl();
  }

  Future<void> connectFromUrl({String? url}) async {
    final Uri baseUri = url != null ? NetworkTools.parseUrl(url) : Uri.base;
    final String? networkSrc = baseUri.queryParameters['rpc'];

    if (networkSrc != null) {
      await connect(NetworkModel(
        url: networkSrc,
        name: networkSrc,
        status: NetworkStatus.offline(),
      ));
    }
  }

  Future<bool> connect(NetworkModel networkModel) async {
    try {
      final InterxStatus? interxStatus = await interxStatusService.getData(networkModel.parsedUri);

      if (interxStatus != null) {
        final NetworkModel newNetwork = NetworkModel.connected(
          from: networkModel,
          status: interxStatus,
        );
        networkProvider.changeCurrentNetwork(newNetwork);
        emit(NetworkConnectorConnectedState(currentNetwork: newNetwork));
      }
      return true;
    } on DioError {
      if (networkModel.parsedUri.isScheme('http')) {
        Uri newUri = networkModel.parsedUri.replace(scheme: 'https');
        return await connect(NetworkModel(
          url: newUri.toString(),
          name: networkModel.name,
          status: networkModel.status,
        ));
      } else {
        return false;
      }
    }
  }

  void disconnect() {
    networkProvider.changeCurrentNetwork(null);
    emit(NetworkConnectorInitialState());
  }
}
