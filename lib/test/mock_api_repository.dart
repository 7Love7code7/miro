import 'package:dio/dio.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/test/mocks/api/api_status.dart';

class MockApiRepository implements ApiRepository {
  @override
  Future<Response<T>> fetchApiStatus<T>(Uri networkUri) async {
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
  void errorIgnore() {
    // TODO(dpajak99): implement errorIgnore
  }
}
