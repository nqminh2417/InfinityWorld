import 'package:flutter/material.dart';

class IwColors {
  const IwColors._();

  static const Color darkBackground = Color(0xFF0B0E1A);
  static const Color darkSurface1 = Color(0xFF14162B);
  static const Color darkSurface2 = Color(0xFF1B1E35);
  static const Color darkBorder = Color(0xFF3F4470);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFAEB3D6);

  static const Color lightBackground = Color(0xFFF6F7FB);
  static const Color lightSurface1 = Color(0xFFFFFFFF);
  static const Color lightSurface2 = Color(0xFFF1F3F9);
  static const Color lightBorder = Color(0xFFE2E6F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);

  static const Color primary = Color(0xFF6B5BFF);
  static const Color primaryBright = Color(0xFFA855F7);
  static const Color darkSecondary = Color(0xFF4CC2FF);
  static const Color lightSecondary = Color(0xFF2563EB);
  static const Color darkError = Color(0xFFEF4444);
  static const Color lightError = Color(0xFFDC2626);

  static Color background(Brightness brightness) {
    return brightness == Brightness.dark ? darkBackground : lightBackground;
  }

  static Color surface1(Brightness brightness) {
    return brightness == Brightness.dark ? darkSurface1 : lightSurface1;
  }

  static Color surface2(Brightness brightness) {
    return brightness == Brightness.dark ? darkSurface2 : lightSurface2;
  }

  static Color border(Brightness brightness) {
    return brightness == Brightness.dark ? darkBorder : lightBorder;
  }

  static Color textPrimary(Brightness brightness) {
    return brightness == Brightness.dark ? darkTextPrimary : lightTextPrimary;
  }

  static Color textSecondary(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkTextSecondary
        : lightTextSecondary;
  }

  static Color secondary(Brightness brightness) {
    return brightness == Brightness.dark ? darkSecondary : lightSecondary;
  }

  static Color error(Brightness brightness) {
    return brightness == Brightness.dark ? darkError : lightError;
  }
}
