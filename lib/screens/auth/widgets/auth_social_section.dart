import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthSocialSection extends StatelessWidget {
  final Function(String) onSocialSignIn;

  const AuthSocialSection({super.key, required this.onSocialSignIn});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton.social(
          content: 'Continue With Apple',
          icon: const AppleIcon(),
          onTap: () => onSocialSignIn('Apple'),
        ),
        SizedBox(height: 16.h),
        AppButton.social(
          content: 'Continue With Google',
          icon: const GoogleIcon(),
          onTap: () => onSocialSignIn('Google'),
        ),
        SizedBox(height: 16.h),
        AppButton.social(
          content: 'Continue With Facebook',
          icon: const FacebookIcon(),
          onTap: () => onSocialSignIn('Facebook'),
        ),
      ],
    );
  }
}
