import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/network_provider.dart';

class UrlPathGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    NetworkProvider networkProvider = globalLocator<NetworkProvider>();
    if (!networkProvider.isConnected) {
      resolver.next(true);
      return;
    }
    if (networkProvider.networkUrl != resolver.route.queryParams.get('rpc') as String?) {
      final Map<String, dynamic> params = <String, dynamic>{
        'rpc': networkProvider.networkUrl,
      };
      resolver.next(false);
      unawaited(router.push(resolver.route.toPageRouteInfo().copyWith(
            queryParams: params,
          )));
    } else {
      resolver.next(true);
    }
  }
}
