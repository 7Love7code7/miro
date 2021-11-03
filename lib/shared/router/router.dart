import 'package:auto_route/annotations.dart';
import 'package:miro/core_wrapper.dart';
import 'package:miro/shared/guards/url_path_guard.dart';
import 'package:miro/views/pages/connection_page/connection_page.dart';
import 'package:miro/views/pages/validators_page/validators_page.dart';
import 'package:miro/views/pages/welcome_page/welcome_page.dart';

@AdaptiveAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
    page: CoreWrapper,
    name: 'CoreRoute',
    path: '/',
    initial: true,
    guards: [UrlPathGuard],
    children: [
      AutoRoute(
        page: WelcomePage,
        name: 'WelcomeRoute',
        path: 'welcome',
        guards: [UrlPathGuard],
      ),
      AutoRoute(
        page: ConnectionPage,
        name: 'ConnectionRoute',
        path: 'connection',
        guards: [UrlPathGuard],
      ),
      AutoRoute(
        page: ValidatorsPage,
        name: 'ValidatorsRoute',
        path: 'validators',
        guards: [UrlPathGuard],
      ),
      RedirectRoute(path: '', redirectTo: 'welcome')
    ],
  ),
])
class $AppRouter {}
