import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/interx_status/interx_status.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/constants/network_health.dart';

abstract class _InterxStatusService {
  /// Throws [DioError]
  Future<InterxStatus?> getData(Uri networkUri);

  Future<NetworkHealthStatus> getHealth(Uri networkUri);
}

class InterxStatusService extends _InterxStatusService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<NetworkHealthStatus> getHealth(Uri networkUri) async {
    try {
      final Response<dynamic> apiStatus = await _apiRepository.fetchApiStatus<dynamic>(networkUri);
      if (apiStatus.statusCode == 200) {
        return NetworkHealthStatus.online;
      }
      return NetworkHealthStatus.offline;
    } on DioError {
      return NetworkHealthStatus.offline;
    }
  }

  @override
  Future<InterxStatus?> getData(Uri networkUri) async {
    try {
      final Response<dynamic> apiStatus = await _apiRepository.fetchApiStatus<dynamic>(networkUri);
      if (apiStatus.data is Map<String, dynamic>) {
        return InterxStatus.fromJson(apiStatus.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } on DioError {
      rethrow;
    }
  }
}
