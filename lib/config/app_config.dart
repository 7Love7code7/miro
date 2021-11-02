import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:miro/config/theme/index.dart';
import 'package:miro/shared/utils/enums.dart';

abstract class AppConfig {
  void initConfig();

  Future<void> updateLang(String? lang);

  Future<void> updateTheme(ThemeMode mode);
}

class AppConfigImpl extends ChangeNotifier implements AppConfig {
  AppConfigImpl() {
    initConfig();
  }

  late Box<String> _prefs;
  late String _locale;
  late ThemeMode _themeMode;

  String get locale {
    return _locale;
  }

  bool get isDarkTheme {
    return _themeMode == ThemeMode.dark;
  }

  ThemeData get themeData {
    return isDarkTheme ? buildDarkTheme(locale) : buildLightTheme(locale);
  }

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
    } on Exception catch (err) {
      print('Error located at getting configuration : $err');
    }
  }

  @override
  Future<void> updateLang(String? lang) async {
    try {
      await _prefs.put('language', lang!);
      notifyListeners();
    } catch (err) {
      print('Error located at changing the language : $err');
    }
  }

  @override
  Future<void> updateTheme(ThemeMode mode) async {
    try {
      await _prefs.put('theme_mode', enumToString(mode));
      _themeMode = mode;
      notifyListeners();
    } catch (err) {
      print('Error located at updating the theme : $err');
      notifyListeners();
    }
  }
}
