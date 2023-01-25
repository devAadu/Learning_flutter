import 'package:flutter/material.dart';

ThemeData? activeTheme;

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey)

);
