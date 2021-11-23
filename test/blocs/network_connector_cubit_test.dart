import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/interx_status_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/test/test_locator.dart';

// ignore_for_file: always_specify_types
Future<void> main() async {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);
  await initTestLocator();

  group('Open connection via url', () {
    blocTest<NetworkConnectorCubit, NetworkConnectorState>(
      'Reads url and opens connection',
      build: () => NetworkConnectorCubit(interxStatusService: globalLocator<InterxStatusService>()),
      act: (NetworkConnectorCubit cubit) =>
          cubit.connectFromUrl(url: 'https://test.test/?rpc=https://online.kira.network'),
      expect: () => [
        NetworkConnectorConnectedState(
          currentNetwork: globalLocator<NetworkProvider>().currentNetwork!,
        ),
      ],
    );

    test('Check if connected', () async {
      final NetworkModel? currentNetwork = globalLocator<NetworkProvider>().currentNetwork;
      expect(currentNetwork, isNot(equals(null)));
      expect(currentNetwork!.isConnected, true);
      expect(currentNetwork.parsedUri.toString(), 'https://online.kira.network');
    });
  });

  group('Open normal connection', () {
    blocTest<NetworkConnectorCubit, NetworkConnectorState>(
      'Sending network request and returns connection state',
      build: () => NetworkConnectorCubit(interxStatusService: globalLocator<InterxStatusService>()),
      act: (NetworkConnectorCubit cubit) =>
          cubit.connectFromUrl(url: 'https://test.test/?rpc=https://online.kira.network'),
      expect: () => [isA<NetworkConnectorConnectedState>()],
    );

    test('Check if connected', () async {
      final NetworkModel? currentConnection = globalLocator<NetworkProvider>().currentNetwork;
      expect(currentConnection, isNot(equals(null)));
      expect(currentConnection!.isConnected, true);
      expect(currentConnection.parsedUri.toString(), 'https://online.kira.network');
    });
  });
}
