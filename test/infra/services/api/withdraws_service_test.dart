import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_resp.dart';
import 'package:miro/infra/services/api/withdraws_service.dart';
import 'package:miro/shared/utils/network_tools.dart';

void main() {
  group('Test of service', () {
    test('check withdraws', () async {
      await initLocator();

      final WithdrawsService withdrawsService = globalLocator<WithdrawsService>();
      final Uri uri = NetworkTools.parseUrl('https://testnet-rpc.kira.network');

      WithdrawsReq withdrawsReq = WithdrawsReq(account: 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8');

      print('data return');
      WithdrawsResp? withdrawsResp = await withdrawsService.getAccountWithdraws(uri, withdrawsReq);

      // final dynamic trans = withdrawsResp.
      print(withdrawsResp);
    });
  });
}
