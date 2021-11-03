import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miro/config/hive.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/app_list_providers.dart';
import 'package:miro/shared/guards/url_path_guard.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await initLocator();
  await initHive();
  setPathUrlStrategy();

  runApp(
    ChangeNotifierProvider.value(
      value: globalLocator<AppConfigProvider>(),
      child: MultiProvider(
        providers: appListProviders,
        child: const CoreApp(),
      ),
    ),
  );
}

class CoreApp extends StatefulWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoreApp();
}

class _CoreApp extends State<CoreApp> {
  final AppRouter appRouter = AppRouter(urlPathGuard: UrlPathGuard());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfigProvider>(
      builder: (_, AppConfigProvider value, Widget? child) {
        return MaterialApp.router(
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
          // showPerformanceOverlay: true,
          debugShowCheckedModeBanner: false,
          locale: Locale(
            globalLocator<AppConfigProvider>().locale,
            globalLocator<AppConfigProvider>().locale.toUpperCase(),
          ),
          theme: globalLocator<AppConfigProvider>().themeData,
          builder: (_, Widget? routerWidget) {
            return routerWidget as Widget;
          },
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
