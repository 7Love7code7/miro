import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme kTextTheme(TextTheme? theme, String? language) {
  /// Please change the font you look according to the langage.
  switch (language) {
    case 'en':
      return GoogleFonts.redHatTextTextTheme(theme);
    case 'pl':
      return GoogleFonts.redHatTextTextTheme(theme);
    default:
      return GoogleFonts.redHatTextTextTheme(theme);
  }
}
