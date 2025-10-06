import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AuthForgotPasswordLink extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AuthForgotPasswordLink({
    super.key,
    required this.onTap,
    this.text = 'Forgot Password?',
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: onTap,
        child: AppText(title: text, style: AppTypography.linkText),
      ),
    );
  }
}
