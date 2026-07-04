import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/theme/app_theme.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';

void main() {
  test('AppTheme exposes Midnight Violet light and dark themes', () {
    expect(AppTheme.light.brightness, Brightness.light);
    expect(AppTheme.dark.brightness, Brightness.dark);
    expect(AppTheme.light.colorScheme.primary, IwColors.primary);
    expect(AppTheme.dark.scaffoldBackgroundColor, IwColors.darkBackground);
    expect(AppTheme.light.textTheme.bodyMedium?.fontFamily, 'Inter');
    expect(AppTheme.light.textTheme.labelLarge?.fontFamily, 'Inter');
    expect(AppTheme.light.textTheme.headlineMedium?.fontFamily, 'Sora');
  });
}
