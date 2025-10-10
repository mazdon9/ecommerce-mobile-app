import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarOptionsBottomSheet extends StatelessWidget {
  const AvatarOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorSchemes.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColorSchemes.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 24.h),
              _buildOption(
                context: context,
                icon: Icons.visibility,
                title: 'View Photo',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement view photo functionality
                },
              ),
              SizedBox(height: 16.h),
              _buildOption(
                context: context,
                icon: Icons.edit,
                title: 'Edit Photo',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement edit photo functionality
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColorSchemes.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColorSchemes.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24.w, color: AppColorSchemes.primary),
            SizedBox(width: 16.w),
            Text(
              title,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColorSchemes.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
