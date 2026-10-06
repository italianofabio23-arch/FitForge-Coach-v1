import 'package:flutter/material.dart';

ThemeData buildFitForgeTheme() {
  const background = Color(0xFF090A0C);
  const surface = Color(0xFF15171B);
  const forgeRed = Color(0xFFFF3B22);
  const forgeOrange = Color(0xFFFF7A18);

  final scheme = ColorScheme.fromSeed(
    seedColor: forgeRed,
    brightness: Brightness.dark,
    surface: surface,
  ).copyWith(
    primary: forgeRed,
    secondary: forgeOrange,
    surface: surface,
  );

  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: background,
    useMaterial3: true,
    fontFamily: 'Roboto',
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFF2A2D33)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF111317),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF32363D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF32363D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: forgeRed, width: 1.5),
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
  backgroundColor: Color(0xFF101216),
  indicatorColor: Color(0x44FF3B22),
),

filledButtonTheme: FilledButtonThemeData(
  style: FilledButton.styleFrom(
    backgroundColor: forgeRed,
    foregroundColor: Colors.white,
    minimumSize: const Size.fromHeight(54),
    padding: const EdgeInsets.symmetric(
      horizontal: 22,
      vertical: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.6,
    ),
  ),
),
);
}
