import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/shared/api_manager.dart';

abstract class ApiRepository {
  /// throws [DioError]
  Future<Response<T>> fetchInterxStatus<T>(Uri networkUri);

  Future<Response<T>> fetchDeposits<T>(Uri networkUri, DepositsReq depositsReq);

  Future<Response<T>> fetchWithdraws<T>(Uri networkUri, WithdrawsReq withdrawsReq);
}

class RemoteApiRepository implements ApiRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> fetchInterxStatus<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/status',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchDeposits<T>(Uri networkUri, DepositsReq depositsReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/depsits',
        queryParameters: depositsReq.toJson(),
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchWithdraws<T>(Uri networkUri, WithdrawsReq withdrawsReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/withdraws',
        queryParameters: withdrawsReq.toJson(),
      );
      return response;
    } on DioError {
      rethrow;
    }
  }
}
