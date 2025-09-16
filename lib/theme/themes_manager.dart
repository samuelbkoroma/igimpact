import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.green,
    // ignore: deprecated_member_use
    background: Colors.grey.shade100,
  ),
  scaffoldBackgroundColor: Colors.grey.shade100,
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
    secondary: Colors.green,
    // ignore: deprecated_member_use
    background: Colors.grey.shade900,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
  brightness: Brightness.dark,
);
