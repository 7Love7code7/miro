// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/annotations.dart' as _i8;
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:miro/core_wrapper.dart' as _i1;
import 'package:miro/shared/guards/url_path_guard.dart' as _i7;
import 'package:miro/views/pages/connection_page/connection_page.dart' as _i3;
import 'package:miro/views/pages/validators_page/validators_page.dart' as _i4;
import 'package:miro/views/pages/welcome_page/welcome_page.dart' as _i2;

class AppRouter extends _i5.RootStackRouter {
  AppRouter(
      {_i6.GlobalKey<_i6.NavigatorState>? navigatorKey,
      required this.urlPathGuard})
      : super(navigatorKey);

  final _i7.UrlPathGuard urlPathGuard;

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    CoreRoute.name: (routeData) {
      return _i5.AdaptivePage<_i8.AutoRoute<dynamic>>(
          routeData: routeData, child: const _i1.CoreWrapper());
    },
    WelcomeRoute.name: (routeData) {
      return _i5.AdaptivePage<_i8.AutoRoute<dynamic>>(
          routeData: routeData, child: const _i2.WelcomePage());
    },
    ConnectionRoute.name: (routeData) {
      return _i5.AdaptivePage<_i8.AutoRoute<dynamic>>(
          routeData: routeData, child: const _i3.ConnectionPage());
    },
    ValidatorsRoute.name: (routeData) {
      return _i5.AdaptivePage<_i8.AutoRoute<dynamic>>(
          routeData: routeData, child: const _i4.ValidatorsPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(CoreRoute.name, path: '/', guards: [
          urlPathGuard
        ], children: [
          _i5.RouteConfig(WelcomeRoute.name,
              path: 'welcome', parent: CoreRoute.name, guards: [urlPathGuard]),
          _i5.RouteConfig(ConnectionRoute.name,
              path: 'connection',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i5.RouteConfig(ValidatorsRoute.name,
              path: 'validators',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i5.RouteConfig('#redirect',
              path: '',
              parent: CoreRoute.name,
              redirectTo: 'welcome',
              fullMatch: true)
        ])
      ];
}

/// generated route for [_i1.CoreWrapper]
class CoreRoute extends _i5.PageRouteInfo<void> {
  const CoreRoute({List<_i5.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'CoreRoute';
}

/// generated route for [_i2.WelcomePage]
class WelcomeRoute extends _i5.PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}

/// generated route for [_i3.ConnectionPage]
class ConnectionRoute extends _i5.PageRouteInfo<void> {
  const ConnectionRoute() : super(name, path: 'connection');

  static const String name = 'ConnectionRoute';
}

/// generated route for [_i4.ValidatorsPage]
class ValidatorsRoute extends _i5.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}
