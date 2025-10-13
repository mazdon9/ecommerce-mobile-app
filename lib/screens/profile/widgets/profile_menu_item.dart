import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColorSchemes.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColorSchemes.black.withAlpha(4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: AppText(
                title: title,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColorSchemes.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: AppColorSchemes.grey,
            ),
          ],
        ),
      ),
    );
  }
}
