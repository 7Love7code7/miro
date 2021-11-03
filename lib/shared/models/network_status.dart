import 'package:miro/shared/constants/network_health.dart';

class NetworkStatus {
  NetworkHealthStatus status;

  NetworkStatus({
    required this.status,
  });

  factory NetworkStatus.online() => NetworkStatus(status: NetworkHealthStatus.online);
  factory NetworkStatus.offline() => NetworkStatus(status: NetworkHealthStatus.offline);
}
