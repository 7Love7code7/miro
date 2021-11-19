import 'package:auto_route/annotations.dart';
import 'package:miro/core_wrapper.dart';
import 'package:miro/shared/guards/url_path_guard.dart';
import 'package:miro/views/pages/connection_page/connection_page.dart';
import 'package:miro/views/pages/create_wallet_page/create_wallet_page.dart';
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
        path: 'wallet',
        guards: [UrlPathGuard],
      ),
      RedirectRoute(path: '', redirectTo: 'welcome'),
    ],
  ),
])
class $AppRouter {}
