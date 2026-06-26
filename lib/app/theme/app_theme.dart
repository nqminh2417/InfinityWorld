import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_radius.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: IwColors.primary,
      brightness: brightness,
    ).copyWith(
      primary: IwColors.primary,
      onPrimary: Colors.white,
      secondary: IwColors.secondary(brightness),
      onSecondary: Colors.white,
      surface: IwColors.surface1(brightness),
      onSurface: IwColors.textPrimary(brightness),
      error: IwColors.error(brightness),
      onError: Colors.white,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: IwColors.background(brightness),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: IwColors.surface1(brightness),
        foregroundColor: IwColors.textPrimary(brightness),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: IwColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: IwRadius.buttonBorderRadius,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: IwRadius.inputBorderRadius),
        focusedBorder: OutlineInputBorder(
          borderRadius: IwRadius.inputBorderRadius,
          borderSide: const BorderSide(color: IwColors.primary),
        ),
      ),
      textTheme: _textTheme(base.textTheme, brightness),
    );
  }

  static TextTheme _textTheme(TextTheme base, Brightness brightness) {
    final textColor = IwColors.textPrimary(brightness);
    final themed = base.apply(bodyColor: textColor, displayColor: textColor);

    return themed.copyWith(
      displayLarge: themed.displayLarge?.copyWith(fontWeight: FontWeight.w700),
      headlineMedium: themed.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      titleLarge: themed.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: themed.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
