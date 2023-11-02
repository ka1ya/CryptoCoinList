import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  dividerColor: const Color.fromARGB(29, 255, 255, 255),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white70),
  scaffoldBackgroundColor: const Color.fromARGB(255, 37, 37, 37),
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 185, 167, 0)),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Color.fromARGB(200, 255, 255, 255),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
);
