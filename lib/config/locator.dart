import 'package:get_it/get_it.dart';
import 'package:miro/config/app_config.dart';

final globalLocator = GetIt.I;
Future initLocator() async {
  globalLocator.registerLazySingleton(() => AppConfigImpl());
}
