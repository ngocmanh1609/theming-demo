import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF386A20);

ThemeData appTheme(Brightness mode, bool useMaterial3) => ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        brightness: mode,
        seedColor: primaryColor,
        primary: primaryColor,
      ),
      useMaterial3: useMaterial3,
    ).copyWith(visualDensity: VisualDensity.standard);
