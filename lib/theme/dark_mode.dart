import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF121212),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.teal[700],
    foregroundColor: Colors.white,
    elevation: 4,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.greenAccent[400],
    foregroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.teal[400]!,         // used for buttons, active icons
    secondary: Colors.greenAccent[400]!,// used for highlights, accents
    surface: Color(0xFF1E1E1E),         // cards, sheets
    background: Color(0xFF121212),      // general background
    onPrimary: Colors.white,            // text on primary
    onSecondary: Colors.black,          // text on secondary
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[100]),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[300]),
    labelLarge: TextStyle(fontSize: 14, color: Colors.greenAccent[100]),
  ),
);