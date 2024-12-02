// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_1/theme%20provider.dart';
import 'settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late bool isDarkTheme;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  Future<void> toggleTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = isDark;
    });
    await prefs.setBool('isDarkTheme', isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enhanced Settings',
      theme: isDarkTheme ? ThemeProvider.darkTheme : ThemeProvider.lightTheme,
      home: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        color: isDarkTheme
            ? ThemeProvider.darkBackground
            : ThemeProvider.lightBackground,
        child: SettingsScreen(
          isDarkTheme: isDarkTheme,
          onThemeChanged: toggleTheme,
          username: '',
          onUsernameChanged: (String) {},
        ),
      ),
    );
  }
}
