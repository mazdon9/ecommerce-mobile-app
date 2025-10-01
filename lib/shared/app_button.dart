import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String content;
  final VoidCallback onTap;
  final double width;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Border? borderColors;
  final String? iconPath;
  final Widget? trailing;

  const AppButton({
    required this.content,
    required this.onTap,
    this.width = double.infinity,
    this.backgroundColor,
    super.key,
    this.textStyle,
    this.borderColors,
    this.iconPath,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        // height: 67.h,
        decoration: BoxDecoration(
          border: borderColors,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 22.5.h, horizontal: 24.w),
        child: Row(
          children: [
            if (iconPath != null)
              Image.asset(
                iconPath!,
                color: AppColorSchemes.green,
                width: 24.w,
                height: 24.w,
              ),
            Expanded(
              child: AppText(
                title: content,
                textAlign: TextAlign.center,
                style:
                    textStyle ??
                    AppTypography.textFont18W600.copyWith(
                      color: backgroundColor == null
                          ? AppColorSchemes.white
                          : AppColorSchemes.green,
                    ),
              ),
            ),
            if (trailing != null) ...[SizedBox(width: 12.w), trailing!],
          ],
        ),
      ),
    );
  }
}
