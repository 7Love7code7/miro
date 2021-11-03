import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';

class ApiManager {
  Future<Response<T>> get<T>({
    required Uri networkUri,
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Dio server = DioForBrowser(BaseOptions(baseUrl: networkUri.toString()));
      return await server.get<T>(path);
    } on DioError {
      rethrow;
    }
  }
}
