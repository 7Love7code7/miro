import 'package:flutter/material.dart';
import 'package:miro/config/theme/content/fonts.dart';

ColorScheme _kColorSchemeLight = ColorScheme.light(
  primary: const Color(0xffFCB433),
  primaryVariant: Colors.grey[300]!,
  secondary: const Color(0xff666666),
  onPrimary: Colors.black,
);

TextTheme _buildLightTextTheme(TextTheme? base, String? lang) {
  var textTheme = kTextTheme(base, lang);
  return textTheme.copyWith();
}

ThemeData buildLightTheme(String? lang) {
  final _baseLight = ThemeData.light();
  return _baseLight.copyWith(
    textTheme: _buildLightTextTheme(_baseLight.textTheme, lang),
    colorScheme: _kColorSchemeLight,
  );
}
