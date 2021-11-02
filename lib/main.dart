import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/hive.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await initLocator();
  await initHive();

  // runApp(ChangeNotifierProvider.value(
  //   value: globalLocator<AppConfigImpl>(),
  //   child: MultiProvider(
  //     providers: appProviders,
  //     child: const CoreApp(),
  //   ),
  // ));
  //
  runApp(ChangeNotifierProvider.value(
    value: globalLocator<AppConfigImpl>(),
    child: const CoreApp(),
  ));
}

class CoreApp extends StatefulWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoreApp();
}

class _CoreApp extends State<CoreApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfigImpl>(
      builder: (context, value, child) {
        return MaterialApp.router(
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
          // showPerformanceOverlay: true,
          debugShowCheckedModeBanner: false,
          locale: Locale(context.read<AppConfigImpl>().locale, context.read<AppConfigImpl>().locale.toUpperCase()),
          theme: context.read<AppConfigImpl>().themeData,
          builder: (context, routerWidget) {
            return routerWidget as Widget;
          },
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
