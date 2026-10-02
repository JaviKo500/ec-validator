import 'package:flutter/material.dart';

const _seedColor = Color(0xFF2747A8);

/// Builds the app theme for the given [brightness].
ThemeData buildAppTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surfaceContainerLowest,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      shape: Border(bottom: BorderSide(color: scheme.outlineVariant)),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerLow,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: scheme.surfaceContainerLowest,
    ),
  );
}

/// Colors for the "valid" state, which Material 3 does not define.
extension StatusColors on ColorScheme {
  bool get _isLight => brightness == Brightness.light;

  Color get success =>
      _isLight ? const Color(0xFF1E7B3A) : const Color(0xFF7DD99A);

  Color get successContainer =>
      _isLight ? const Color(0xFFDDF4E3) : const Color(0xFF1F3B28);

  Color get onSuccessContainer =>
      _isLight ? const Color(0xFF0B3D1C) : const Color(0xFFB9F0C8);
}
