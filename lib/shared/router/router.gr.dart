// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../core_wrapper.dart' as _i1;
import '../../views/pages/connection_page/connection_page.dart' as _i4;
import '../../views/pages/create_wallet_page/create_wallet_page.dart' as _i6;
import '../../views/pages/dashboard_page/dashboard_page.dart' as _i3;
import '../../views/pages/login_page/login_keyfile_page.dart' as _i7;
import '../../views/pages/login_page/login_mnemonic_page.dart' as _i8;
import '../../views/pages/login_page/login_saifu_page.dart' as _i9;
import '../../views/pages/validators_page/validators_page.dart' as _i5;
import '../../views/pages/welcome_page/welcome_page.dart' as _i2;
import '../guards/url_path_guard.dart' as _i12;

class AppRouter extends _i10.RootStackRouter {
  AppRouter(
      {_i11.GlobalKey<_i11.NavigatorState>? navigatorKey,
      required this.urlPathGuard})
      : super(navigatorKey);

  final _i12.UrlPathGuard urlPathGuard;

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    CoreRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i1.CoreWrapper(),
          opaque: true,
          barrierDismissible: false);
    },
    WelcomeRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i2.WelcomePage(),
          opaque: true,
          barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i3.DashboardPage(),
          opaque: true,
          barrierDismissible: false);
    },
    ConnectionRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i4.ConnectionPage(),
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i5.ValidatorsPage(),
          opaque: true,
          barrierDismissible: false);
    },
    CreateWalletRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i6.CreateWalletPage(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginKeyfileRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i7.LoginKeyfilePage(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginMnemonicRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i8.LoginMnemonicPage(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginSaifuRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i9.LoginSaifuPage(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(CoreRoute.name, path: '/', guards: [
          urlPathGuard
        ], children: [
          _i10.RouteConfig(WelcomeRoute.name,
              path: 'welcome', parent: CoreRoute.name, guards: [urlPathGuard]),
          _i10.RouteConfig(DashboardRoute.name,
              path: 'dashboard',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i10.RouteConfig(ConnectionRoute.name,
              path: 'connection',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i10.RouteConfig(ValidatorsRoute.name,
              path: 'validators',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i10.RouteConfig(CreateWalletRoute.name,
              path: 'create-wallet',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i10.RouteConfig(LoginKeyfileRoute.name,
              path: 'login-keyfile',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i10.RouteConfig(LoginMnemonicRoute.name,
              path: 'login-mnemonic',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i10.RouteConfig(LoginSaifuRoute.name,
              path: 'login-saifu',
              parent: CoreRoute.name,
              guards: [urlPathGuard]),
          _i10.RouteConfig('#redirect',
              path: '',
              parent: CoreRoute.name,
              redirectTo: 'welcome',
              fullMatch: true)
        ])
      ];
}

/// generated route for [_i1.CoreWrapper]
class CoreRoute extends _i10.PageRouteInfo<void> {
  const CoreRoute({List<_i10.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'CoreRoute';
}

/// generated route for [_i2.WelcomePage]
class WelcomeRoute extends _i10.PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}

/// generated route for [_i3.DashboardPage]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i4.ConnectionPage]
class ConnectionRoute extends _i10.PageRouteInfo<void> {
  const ConnectionRoute() : super(name, path: 'connection');

  static const String name = 'ConnectionRoute';
}

/// generated route for [_i5.ValidatorsPage]
class ValidatorsRoute extends _i10.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i6.CreateWalletPage]
class CreateWalletRoute extends _i10.PageRouteInfo<void> {
  const CreateWalletRoute() : super(name, path: 'create-wallet');

  static const String name = 'CreateWalletRoute';
}

/// generated route for [_i7.LoginKeyfilePage]
class LoginKeyfileRoute extends _i10.PageRouteInfo<void> {
  const LoginKeyfileRoute() : super(name, path: 'login-keyfile');

  static const String name = 'LoginKeyfileRoute';
}

/// generated route for [_i8.LoginMnemonicPage]
class LoginMnemonicRoute extends _i10.PageRouteInfo<void> {
  const LoginMnemonicRoute() : super(name, path: 'login-mnemonic');

  static const String name = 'LoginMnemonicRoute';
}

/// generated route for [_i9.LoginSaifuPage]
class LoginSaifuRoute extends _i10.PageRouteInfo<void> {
  const LoginSaifuRoute() : super(name, path: 'login-saifu');

  static const String name = 'LoginSaifuRoute';
}
