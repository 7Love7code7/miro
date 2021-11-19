import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/test/mocks/api/api_status.dart';

class MockApiRepository implements ApiRepository {
  @override
  Future<Response<T>> fetchInterxStatus<T>(Uri networkUri) async {
    int statusCode = 404;
    Map<String, dynamic>? mockedResponse;

    if (networkUri.host == 'online.kira.network') {
      statusCode = 200;
      mockedResponse = apiStatusMock;
    }

    return Response<T>(
      statusCode: statusCode,
      data: mockedResponse as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchDeposits<T>(Uri networkUri, DepositsReq depositsReq) {
    // TODO(Karol): implement fetchDeposits
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> fetchWithdraws<T>(Uri networkUri, WithdrawsReq withdrawsReq) {
    // TODO(Karol): implement fetchWithdraws
    throw UnimplementedError();
  }
}
