import 'package:flutter/material.dart';

/// context extensions based on BuildContext
extension ContextExtension on BuildContext {
  /// screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Theme
  ThemeData get theme => Theme.of(this);

  /// TextTheme
  TextTheme get textTheme => theme.textTheme;

  /// ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// ColorScheme surface
  Color get surfaceColor => colorScheme.surface;
}
