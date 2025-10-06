import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPageTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AuthPageTitle({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: title, style: AppTypography.pageTitle),
        if (subtitle != null) ...[
          SizedBox(height: 16.h),
          AppText(title: subtitle!, style: AppTypography.bodyMedium),
        ],
      ],
    );
  }
}
