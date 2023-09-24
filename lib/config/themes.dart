import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.orange[400],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange)),
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
  );
}
