import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:miro/config/theme/index.dart';
import 'package:miro/shared/app_logger.dart';
import 'package:miro/shared/utils/enums.dart';

abstract class AppConfigProvider extends ChangeNotifier {
  String get locale;
  bool get isDarkTheme;
  ThemeData get themeData;
  void initConfig();

  Future<void> updateLang(String? lang);

  Future<void> updateTheme(ThemeMode mode);
}

class AppConfigProviderImpl extends AppConfigProvider {
  AppConfigProviderImpl() {
    initConfig();
  }

  late Box<String> _prefs;
  late String _locale;
  late ThemeMode _themeMode;

  @override
  String get locale => _locale;

  @override
  bool get isDarkTheme => _themeMode == ThemeMode.dark;

  @override
  ThemeData get themeData => isDarkTheme ? buildDarkTheme(locale) : buildLightTheme(locale);

  @override
  void initConfig() {
    try {
      _prefs = Hive.box<String>('configuration');
      _locale = _prefs.get('language', defaultValue: 'en')!;
      _themeMode = enumFromString(
        ThemeMode.values,
        _prefs.get(
          'theme_mode',
          defaultValue: enumToString(ThemeMode.system),
        )!,
      );
      notifyListeners();
    } on Exception catch (error) {
      AppLogger().log(message: error.toString(), logLevel: LogLevel.terribleFailure);
    }
  }

  @override
  Future<void> updateLang(String? lang) async {
    try {
      await _prefs.put('language', lang!);
      notifyListeners();
    } on Exception catch (error) {
      AppLogger().log(message: error.toString(), logLevel: LogLevel.error);
    }
  }

  @override
  Future<void> updateTheme(ThemeMode mode) async {
    try {
      await _prefs.put('theme_mode', enumToString(mode));
      _themeMode = mode;
      notifyListeners();
    } on Exception catch (error) {
      AppLogger().log(message: error.toString(), logLevel: LogLevel.error);
    }
  }
}
