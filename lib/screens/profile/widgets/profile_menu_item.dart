import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileMenuItem({super.key, required this.title, required this.onTap, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    title: title,
                    style: AppTypography.bodyLarge.copyWith(color: AppColorSchemes.black),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.w, color: AppColorSchemes.grey),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, thickness: 1, color: AppColorSchemes.grey.withOpacity(0.2)),
      ],
    );
  }
}
