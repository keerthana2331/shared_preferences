// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeProvider {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.tealAccent,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.4),
      elevation: 4,
      margin: EdgeInsets.all(8),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purpleAccent,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
    ),
    cardTheme: CardTheme(
      color: Color(0xFF1E1E1E),
      shadowColor: Colors.black.withOpacity(0.7),
      elevation: 4,
      margin: EdgeInsets.all(8),
    ),
  );

  static const lightBackground = Colors.white;
  static const darkBackground = Color(0xFF121212);
}
