import 'package:flutter/material.dart';

class AppTheme {
  static const Color _bgMain = Color(0xFF0A0A0A);
  static const Color _bgSurface = Color(0xFF1A1A1A);
  static const Color _accentPrimary = Color(0xFFEAB308);
  static const Color _textPrimary = Color(0xFFF5F5F5);
  static const Color _textSecondary = Color(0xFFA3A3A3);
  static const Color _textDisabled = Color(0xFF646464);
  static const Color _borderColor = Color(0xFF262626);
  static const Color _danger = Color(0xFFEF4444);

  static ThemeData get blackTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bgMain,
      
      // Fehler 2 & 3 gelöst: 'background' wurde durch 'surface' ersetzt
      colorScheme: const ColorScheme.dark(
        surface: _bgSurface,
        onSurface: _textPrimary,
        primary: _accentPrimary,
        onPrimary: Colors.black,
        secondary: Color(0xFFFACC15),
        error: _danger,
        outline: _borderColor,
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: _textPrimary),
        bodyMedium: TextStyle(color: _textSecondary),
        bodySmall: TextStyle(color: _textDisabled),
      ),

      // Fehler 1 gelöst: Der Parameter heißt 'cardTheme', 
      // aber der Typ muss 'CardThemeData' sein (oder CardTheme nutzen)
      cardTheme: CardThemeData( 
        color: _bgSurface,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: _borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Fehler 4 & 5 gelöst: MaterialStateProperty -> WidgetStateProperty
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(_borderColor),
        trackColor: WidgetStateProperty.all(const Color(0xFF050505)),
      ),
    );
  }
}