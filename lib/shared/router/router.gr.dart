// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../core_wrapper.dart' as _i1;
import '../../views/pages/connection_page/connection_page.dart' as _i3;
import '../../views/pages/create_wallet_page/create_wallet_page.dart' as _i5;
import '../../views/pages/validators_page/validators_page.dart' as _i4;
import '../../views/pages/welcome_page/welcome_page.dart' as _i2;
import '../guards/url_path_guard.dart' as _i8;

class AppRouter extends _i6.RootStackRouter {
  AppRouter(
      {_i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
      required this.urlPathGuard})
      : super(navigatorKey);

  final _i8.UrlPathGuard urlPathGuard;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    CoreRoute.name: (routeData) {
      return _i6.CustomPage<void>(
          routeData: routeData,
          child: const _i1.CoreWrapper(),
          opaque: true,
          barrierDismissible: false);
    },
    WelcomeRoute.name: (routeData) {
      return _i6.CustomPage<void>(
          routeData: routeData,
          child: const _i2.WelcomePage(),
          opaque: true,
          barrierDismissible: false);
    },
    ConnectionRoute.name: (routeData) {
      return _i6.CustomPage<void>(
          routeData: routeData,
          child: const _i3.ConnectionPage(),
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i6.CustomPage<void>(
          routeData: routeData,
          child: const _i4.ValidatorsPage(),
          opaque: true,
          barrierDismissible: false);
    },
    CreateWalletRoute.name: (routeData) {
      return _i6.CustomPage<void>(
          routeData: routeData,
          child: const _i5.CreateWalletPage(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(CoreRoute.name, path: '/', guards: [
          urlPathGuard
        ], children: [
          _i6.RouteConfig(WelcomeRoute.name,
              path: 'welcome', parent: CoreRoute.name, guards: [urlPathGuard]),
          _i6.RouteConfig(ConnectionRoute.name,
              path: 'connection',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i6.RouteConfig(ValidatorsRoute.name,
              path: 'validators',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i6.RouteConfig(CreateWalletRoute.name,
              path: 'wallet', parent: CoreRoute.name, guards: [urlPathGuard]),
          _i6.RouteConfig('#redirect',
              path: '',
              parent: CoreRoute.name,
              redirectTo: 'welcome',
              fullMatch: true)
        ])
      ];
}

/// generated route for [_i1.CoreWrapper]
class CoreRoute extends _i6.PageRouteInfo<void> {
  const CoreRoute({List<_i6.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'CoreRoute';
}

/// generated route for [_i2.WelcomePage]
class WelcomeRoute extends _i6.PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}

/// generated route for [_i3.ConnectionPage]
class ConnectionRoute extends _i6.PageRouteInfo<void> {
  const ConnectionRoute() : super(name, path: 'connection');

  static const String name = 'ConnectionRoute';
}

/// generated route for [_i4.ValidatorsPage]
class ValidatorsRoute extends _i6.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i5.CreateWalletPage]
class CreateWalletRoute extends _i6.PageRouteInfo<void> {
  const CreateWalletRoute() : super(name, path: 'wallet');

  static const String name = 'CreateWalletRoute';
}
