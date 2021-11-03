import 'package:dio/dio.dart';
import 'package:miro/shared/api_manager.dart';

abstract class ApiRepository {
  /// throws [DioError]
  Future<Response<T>> fetchApiStatus<T>(Uri networkUri);
  void errorIgnore();
}

class RemoteApiRepository implements ApiRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> fetchApiStatus<T>(Uri networkUri) async {
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
  void errorIgnore() {
    // TODO(dpajak99): remove it when create next method
  }
}
