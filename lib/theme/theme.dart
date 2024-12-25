import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    dividerColor: Colors.white24,
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 31, 31, 31),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
    listTileTheme: const ListTileThemeData(iconColor: Colors.white),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
      labelSmall: TextStyle(
          color: Colors.white.withValues(alpha: 0.6),
          fontWeight: FontWeight.w700,
          fontSize: 14),
    ));
