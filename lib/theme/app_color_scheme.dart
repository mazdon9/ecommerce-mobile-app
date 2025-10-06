import 'package:flutter/material.dart';

class AppColorSchemes {
  // Primary Colors - Based on UI design (Purple theme)
  static const Color primary = Color(0xFF8B5CF6); // Purple
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF7C3AED);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF8FAFC); // Light gray
  static const Color card = Color(0xFFFFFFFF);

  // Text Colors
  static const Color black = Color(0xFF1E293B); // Dark gray
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF64748B); // Medium gray
  static const Color greyLight = Color(0xFF94A3B8); // Light gray
  static const Color lightWhite = Color(0xFFF1F5F9);

  // Input Colors
  static const Color inputBorder = Color(0xFFE2E8F0);
  static const Color inputFill = Color(0xFFF1F5F9);
  static const Color inputFocused = primary;

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Social Colors
  static const Color apple = Color(0xFF000000);
  static const Color google = Color(0xFF4285F4);
  static const Color facebook = Color(0xFF1877F2);

  // Legacy colors (keeping for backward compatibility)
  static const Color green = Color(0xff53B175);
  static const Color darkGreen = Color(0xff489E67);
  static const Color darkBlue = Color(0xFF081854);
}
