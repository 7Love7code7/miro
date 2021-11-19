import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_cosmos/balance/request/balance_req.dart';

abstract class ApiKiraRepository {
  Future<Response<T>> fetchBalance<T>(Uri networkUri, BalanceReq balanceReq);

  void ignore();
}