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
  final TextTheme textTheme = kTextTheme(base, lang);
  return textTheme.copyWith();
}

ThemeData buildDarkTheme(String? lang) {
  final ThemeData baseDark = ThemeData.light();
  return baseDark.copyWith(
    textTheme: _buildDarkTextTheme(baseDark.textTheme, lang),
    colorScheme: _kColorSchemeDark,
  );
}
