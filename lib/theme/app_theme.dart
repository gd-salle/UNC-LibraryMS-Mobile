import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.leagueSpartan().fontFamily,
    primarySwatch: Colors.red,
    textTheme: TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
