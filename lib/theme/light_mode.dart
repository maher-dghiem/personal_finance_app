import 'package:flutter/material.dart';
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.white,
    elevation: 4,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.greenAccent,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.teal,            // used for buttons, active icons
    secondary: Colors.greenAccent,  // used for highlights, accents
    surface: Colors.white,          // cards, sheets
    background: Colors.grey[100]!,  // general background
    onPrimary: Colors.white,        // text on primary
    onSecondary: Colors.black,      // text on secondary
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[900]),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[800]),
    labelLarge: TextStyle(fontSize: 14, color: Colors.green[700]),
  ),
);