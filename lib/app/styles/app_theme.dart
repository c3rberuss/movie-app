import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/styles/palette.dart';

class AppTheme {
  static final ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Palette.primary,
    textTheme: GoogleFonts.khulaTextTheme(),
    cursorColor: Palette.dark,
    scaffoldBackgroundColor: Palette.darkLight,
    splashColor: Palette.dark.withOpacity(0.3),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: Palette.primary.withOpacity(0.7),
    bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
      backgroundColor: Palette.dark,
      selectedItemColor: Palette.primary,
      unselectedItemColor: Palette.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: ThemeData.dark().inputDecorationTheme.copyWith(
          focusColor: Palette.dark,
        ),
  );
}
