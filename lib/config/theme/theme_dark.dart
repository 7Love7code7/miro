import 'package:flutter/material.dart';
import 'package:miro/config/theme/content/fonts.dart';

ColorScheme _kColorSchemeDark = ColorScheme.dark(
  primary: const Color(0xffFCB433),
  primaryVariant: Colors.grey[300]!,
  secondary: const Color(0xffbbbbbb),
  background: const Color(0xff2E2E2E),
  onPrimary: Colors.black,
);

TextTheme _buildDarkTextTheme(TextTheme? base, String? lang) {
  var textTheme = kTextTheme(base, lang);
  return textTheme.copyWith();
}

ThemeData buildDarkTheme(String? lang) {
  final _baseLight = ThemeData.light();
  return _baseLight.copyWith(
    textTheme: _buildDarkTextTheme(_baseLight.textTheme, lang),
    colorScheme: _kColorSchemeDark,
  );
}
