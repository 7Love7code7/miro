import 'package:flutter/material.dart';
import 'package:miro/config/theme/content/fonts.dart';

ColorScheme _kColorSchemeLight = ColorScheme.light(
  primary: const Color(0xffFCB433),
  primaryVariant: Colors.grey[300]!,
  secondary: const Color(0xff666666),
  onPrimary: Colors.black,
);

TextTheme _buildLightTextTheme(TextTheme? base, String? lang) {
  final TextTheme textTheme = kTextTheme(base, lang);
  return textTheme.copyWith();
}

ThemeData buildLightTheme(String? lang) {
  final ThemeData baseLight = ThemeData.light();
  return baseLight.copyWith(
    textTheme: _buildLightTextTheme(baseLight.textTheme, lang),
    colorScheme: _kColorSchemeLight,
  );
}
