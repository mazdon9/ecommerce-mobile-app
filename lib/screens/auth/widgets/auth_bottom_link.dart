import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AuthBottomLink extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onTap;

  const AuthBottomLink({
    super.key,
    required this.question,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(title: question, style: AppTypography.bodyMedium),
        GestureDetector(
          onTap: onTap,
          child: AppText(
            title: actionText,
            style: AppTypography.linkText.copyWith(
              color: AppColorSchemes.black,
            ),
          ),
        ),
      ],
    );
  }
}
