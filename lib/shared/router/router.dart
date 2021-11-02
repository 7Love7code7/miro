import 'package:auto_route/annotations.dart';
import 'package:miro/views/screens/welcome_screen/welcome_screen.dart';

@AdaptiveAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute<AutoRoute>(
    page: WelcomeScreen,
    name: 'WelcomeRoute',
    path: '/',
    initial: true,
    // guards: [LoginGuard]
  ),
])
class $AppRouter {}
