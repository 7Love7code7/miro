import 'package:flutter_test/flutter_test.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/network_status.dart';

void main() {
  group('ConnectionProviderTest', () {
    test('Check initial network data', () async {
      NetworkProvider networkProvider = NetworkProvider();
      expect(networkProvider.isConnected, false);
      expect(networkProvider.currentNetwork, null);
    });

    test('Check network data after connect', () async {
      NetworkProvider networkProvider = NetworkProvider();
      NetworkModel testNetworkModel = NetworkModel(
        url: 'testnet-rpc.kira.network',
        name: 'testnet-test',
        status: NetworkStatus.offline(),
      );
      networkProvider.changeCurrentNetwork(testNetworkModel);

      expect(networkProvider.isConnected, true);
      expect(networkProvider.currentNetwork, testNetworkModel);
    });
  });
}
