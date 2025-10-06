import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppButtonType { primary, secondary, social, text }

class AppButton extends StatelessWidget {
  final String content;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final AppButtonType type;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Border? border;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final Widget? trailing;
  final bool isLoading;
  final bool isEnabled;

  const AppButton({
    required this.content,
    required this.onTap,
    this.width,
    this.height,
    this.type = AppButtonType.primary,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.border,
    this.borderRadius,
    this.icon,
    this.trailing,
    this.isLoading = false,
    this.isEnabled = true,
    super.key,
  });

  // Primary button - Purple background, white text
  factory AppButton.primary({
    required String content,
    required VoidCallback onTap,
    double? width,
    double? height,
    bool isLoading = false,
    bool isEnabled = true,
    Widget? icon,
  }) {
    return AppButton(
      content: content,
      onTap: onTap,
      width: width,
      height: height,
      type: AppButtonType.primary,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
    );
  }

  // Social button - White background, black text, with icon
  factory AppButton.social({
    required String content,
    required VoidCallback onTap,
    required Widget icon,
    double? width,
    double? height,
    bool isEnabled = true,
  }) {
    return AppButton(
      content: content,
      onTap: onTap,
      width: width,
      height: height,
      type: AppButtonType.social,
      icon: icon,
      isEnabled: isEnabled,
    );
  }

  // Text button - No background, colored text
  factory AppButton.text({
    required String content,
    required VoidCallback onTap,
    Color? textColor,
    bool isEnabled = true,
  }) {
    return AppButton(
      content: content,
      onTap: onTap,
      type: AppButtonType.text,
      textColor: textColor,
      isEnabled: isEnabled,
    );
  }

  Color get _backgroundColor {
    if (backgroundColor != null) return backgroundColor!;

    switch (type) {
      case AppButtonType.primary:
        return isEnabled ? AppColorSchemes.primary : AppColorSchemes.grey;
      case AppButtonType.social:
        return AppColorSchemes.white;
      case AppButtonType.secondary:
        return AppColorSchemes.surface;
      case AppButtonType.text:
        return Colors.transparent;
    }
  }

  Color get _textColor {
    if (textColor != null) return textColor!;

    switch (type) {
      case AppButtonType.primary:
        return AppColorSchemes.white;
      case AppButtonType.social:
      case AppButtonType.secondary:
        return AppColorSchemes.black;
      case AppButtonType.text:
        return AppColorSchemes.primary;
    }
  }

  Border? get _border {
    if (border != null) return border;

    switch (type) {
      case AppButtonType.social:
        return Border.all(color: AppColorSchemes.inputBorder, width: 1);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled && !isLoading ? onTap : null,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 56.h,
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: _border,
          borderRadius: borderRadius ?? BorderRadius.circular(30.r),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(_textColor),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, SizedBox(width: 12.w)],
                  Flexible(
                    child: AppText(
                      title: content,
                      textAlign: TextAlign.center,
                      style:
                          textStyle ??
                          AppTypography.buttonLarge.copyWith(color: _textColor),
                    ),
                  ),
                  if (trailing != null) ...[SizedBox(width: 12.w), trailing!],
                ],
              ),
      ),
    );
  }
}
