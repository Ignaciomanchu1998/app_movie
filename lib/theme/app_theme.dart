import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.black;

  static const Color screen = Colors.white;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: screen,
      centerTitle: false,
    ),
  );
}
