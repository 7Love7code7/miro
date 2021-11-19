import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';

abstract class _DepositsService {
  Future<DepositsResp?> getAccountDeposits(Uri networkUri, DepositsReq depositsReq);
  void ignoreMethod();
}

class DepositService implements _DepositsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<DepositsResp?> getAccountDeposits(Uri networkUri, DepositsReq depositsReq) async {
    try {
      final Response<dynamic> response = await _apiRepository.fetchDeposits<dynamic>(networkUri, depositsReq);
      return DepositsResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }

  @override
  void ignoreMethod() {
    // TODO(Karol): implement ignoreMethod
  }

}