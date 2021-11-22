// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../core_wrapper.dart' as _i1;
import '../../views/pages/connection_page/connection_page.dart' as _i4;
import '../../views/pages/create_wallet_page/create_wallet_page.dart' as _i6;
import '../../views/pages/dashboard_page/dashboard_page.dart' as _i3;
import '../../views/pages/login_via_keyfile_page/login_via_keyfile_page.dart'
    as _i7;
import '../../views/pages/login_via_mnemonic_page/login_via_mnemonic_page.dart'
    as _i8;
import '../../views/pages/validators_page/validators_page.dart' as _i5;
import '../../views/pages/welcome_page/welcome_page.dart' as _i2;
import '../guards/url_path_guard.dart' as _i11;

class AppRouter extends _i9.RootStackRouter {
  AppRouter(
      {_i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
      required this.urlPathGuard})
      : super(navigatorKey);

  final _i11.UrlPathGuard urlPathGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CoreRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i1.CoreWrapper(),
          opaque: true,
          barrierDismissible: false);
    },
    WelcomeRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i2.WelcomePage(),
          opaque: true,
          barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i3.DashboardPage(),
          opaque: true,
          barrierDismissible: false);
    },
    ConnectionRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i4.ConnectionPage(),
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i5.ValidatorsPage(),
          opaque: true,
          barrierDismissible: false);
    },
    CreateWalletRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i6.CreateWalletPage(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginViaKeyfileRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i7.LoginViaKeyfilePage(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginViaMnemonicRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i8.LoginViaMnemonicPage(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(CoreRoute.name, path: '/', guards: [
          urlPathGuard
        ], children: [
          _i9.RouteConfig(WelcomeRoute.name,
              path: 'welcome', parent: CoreRoute.name, guards: [urlPathGuard]),
          _i9.RouteConfig(DashboardRoute.name,
              path: 'dashboard',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i9.RouteConfig(ConnectionRoute.name,
              path: 'connection',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i9.RouteConfig(ValidatorsRoute.name,
              path: 'validators',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i9.RouteConfig(CreateWalletRoute.name,
              path: 'create-wallet',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i9.RouteConfig(LoginViaKeyfileRoute.name,
              path: 'login-via-keyfile',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i9.RouteConfig(LoginViaMnemonicRoute.name,
              path: 'login-via-mnemonic',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i9.RouteConfig('#redirect',
              path: '',
              parent: CoreRoute.name,
              redirectTo: 'welcome',
              fullMatch: true)
        ])
      ];
}

/// generated route for [_i1.CoreWrapper]
class CoreRoute extends _i9.PageRouteInfo<void> {
  const CoreRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'CoreRoute';
}

/// generated route for [_i2.WelcomePage]
class WelcomeRoute extends _i9.PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}

/// generated route for [_i3.DashboardPage]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i4.ConnectionPage]
class ConnectionRoute extends _i9.PageRouteInfo<void> {
  const ConnectionRoute() : super(name, path: 'connection');

  static const String name = 'ConnectionRoute';
}

/// generated route for [_i5.ValidatorsPage]
class ValidatorsRoute extends _i9.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i6.CreateWalletPage]
class CreateWalletRoute extends _i9.PageRouteInfo<void> {
  const CreateWalletRoute() : super(name, path: 'create-wallet');

  static const String name = 'CreateWalletRoute';
}

/// generated route for [_i7.LoginViaKeyfilePage]
class LoginViaKeyfileRoute extends _i9.PageRouteInfo<void> {
  const LoginViaKeyfileRoute() : super(name, path: 'login-via-keyfile');

  static const String name = 'LoginViaKeyfileRoute';
}

/// generated route for [_i8.LoginViaMnemonicPage]
class LoginViaMnemonicRoute extends _i9.PageRouteInfo<void> {
  const LoginViaMnemonicRoute() : super(name, path: 'login-via-mnemonic');

  static const String name = 'LoginViaMnemonicRoute';
}
