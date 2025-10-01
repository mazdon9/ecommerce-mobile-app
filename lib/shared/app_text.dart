import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AppText({required this.title, this.style, this.textAlign, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style:
          style ??
          TextStyle(
            color: AppColorSchemes.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
