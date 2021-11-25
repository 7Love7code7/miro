import 'package:auto_route/annotations.dart';
import 'package:miro/core_wrapper.dart';
import 'package:miro/shared/guards/url_path_guard.dart';
import 'package:miro/views/pages/connection_page/connection_page.dart';
import 'package:miro/views/pages/create_wallet_page/create_wallet_page.dart';
import 'package:miro/views/pages/dashboard_page/dashboard_page.dart';
import 'package:miro/views/pages/login_page/login_keyfile_page.dart';
import 'package:miro/views/pages/login_page/login_mnemonic_page.dart';
import 'package:miro/views/pages/login_page/login_saifu_page.dart';
import 'package:miro/views/pages/validators_page/validators_page.dart';
import 'package:miro/views/pages/welcome_page/welcome_page.dart';

// part 'router.gr.dart';

// ignore_for_file: always_specify_types
@CustomAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute<void>(
    page: CoreWrapper,
    name: 'CoreRoute',
    path: '/',
    initial: true,
    guards: [UrlPathGuard],
    children: [
      AutoRoute<void>(
        page: WelcomePage,
        name: 'WelcomeRoute',
        path: 'welcome',
        guards: [UrlPathGuard],
      ),
      AutoRoute<void>(
        page: DashboardPage,
        name: 'DashboardRoute',
        path: 'dashboard',
        guards: [UrlPathGuard],
      ),
      AutoRoute<void>(
        page: ConnectionPage,
        name: 'ConnectionRoute',
        path: 'connection',
        guards: [UrlPathGuard],
      ),
      AutoRoute<void>(
        page: ValidatorsPage,
        name: 'ValidatorsRoute',
        path: 'validators',
        guards: [UrlPathGuard],
      ),
      AutoRoute<void>(
        page: CreateWalletPage,
        name: 'CreateWalletRoute',
        path: 'create-wallet',
        guards: [UrlPathGuard],
      ),
      AutoRoute<void>(
        page: LoginKeyfilePage,
        name: 'LoginKeyfileRoute',
        path: 'login-keyfile',
        guards: [UrlPathGuard],
      ),
      AutoRoute<void>(
        page: LoginMnemonicPage,
        name: 'LoginMnemonicRoute',
        path: 'login-mnemonic',
        guards: [UrlPathGuard],
      ),
      AutoRoute<void>(
        page: LoginSaifuPage,
        name: 'LoginSaifuRoute',
        path: 'login-saifu',
        guards: [UrlPathGuard],
      ),
      RedirectRoute(path: '', redirectTo: 'welcome'),
    ],
  ),
])
class $AppRouter {}
