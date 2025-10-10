import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText = 'See All',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.textFont18W600),
        if (actionText != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(actionText!, style: AppTypography.linkText),
          ),
      ],
    );
  }
}
