import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
  // Base font family - Using Circular for the UI design
  static const String fontFamily = 'Circular';
  
  // Logo/Brand text styles
  static TextStyle get logoLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
    color: AppColorSchemes.white,
    letterSpacing: 2.0,
  );
  
  // Page title styles
  static TextStyle get pageTitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColorSchemes.black,
    height: 1.2,
  );
  
  // Button text styles
  static TextStyle get buttonLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColorSchemes.white,
    height: 1.2,
  );
  
  static TextStyle get buttonMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.white,
    height: 1.2,
  );
  
  // Input field styles
  static TextStyle get inputText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColorSchemes.black,
    height: 1.4,
  );
  
  static TextStyle get inputLabel => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.black,
    height: 1.3,
  );
  
  static TextStyle get inputHint => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColorSchemes.grey,
    height: 1.4,
  );
  
  // Link/Action text styles
  static TextStyle get linkText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.primary,
    height: 1.3,
  );
  
  static TextStyle get linkSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColorSchemes.grey,
    height: 1.3,
  );
  
  // Body text styles
  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColorSchemes.grey,
    height: 1.5,
  );
  
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColorSchemes.black,
    height: 1.5,
  );
  
  // Social button text styles
  static TextStyle get socialButton => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.black,
    height: 1.2,
  );
  
  // Legacy styles (keeping for backward compatibility)
  static final TextStyle textFont18W600 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColorSchemes.black,
  );
  
  static final TextStyle textFont48W600 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w600,
    color: AppColorSchemes.white,
  );
  
  static final TextStyle textFontI32W800 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w800,
    color: AppColorSchemes.white,
  );
  
  static final TextStyle textFontI14W500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.white,
  );
  
  static final TextStyle textFont14W500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.black,
  );
  
  static final TextStyle textFont16W500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.black,
  );
  
  static final TextStyle textFont26W600 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
    color: AppColorSchemes.black,
  );
  
  static final TextStyle textFont22W600 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: AppColorSchemes.black,
  );
  
  static final TextStyle textFont16W600 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColorSchemes.black,
  );
  
  static final TextStyle textFontI12W500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColorSchemes.white,
  );
}
