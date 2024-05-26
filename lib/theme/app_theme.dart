import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.red,
    textTheme: TextTheme(
      headline6: GoogleFonts.leagueSpartan(),
      bodyText2: GoogleFonts.leagueSpartan(),
      button: GoogleFonts.leagueSpartan(),
    ),
  );
}
