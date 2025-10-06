import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const SocialIcon({super.key, required this.icon, this.color, this.size});

  factory SocialIcon.apple() {
    return const SocialIcon(icon: Icons.apple, color: AppColorSchemes.apple);
  }

  factory SocialIcon.google() {
    return const SocialIcon(
      icon: Icons.g_mobiledata,
      color: AppColorSchemes.google,
    );
  }

  factory SocialIcon.facebook() {
    return const SocialIcon(
      icon: Icons.facebook,
      color: AppColorSchemes.facebook,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? AppColorSchemes.black,
      size: size ?? 20.w,
    );
  }
}

// Custom Google icon widget since Icons.g_mobiledata might not look good
class GoogleIcon extends StatelessWidget {
  final double? size;

  const GoogleIcon({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 20.w,
      height: size ?? 20.w,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            fontSize: (size ?? 20.w) * 0.7,
            fontWeight: FontWeight.bold,
            color: AppColorSchemes.google,
          ),
        ),
      ),
    );
  }
}

// Apple icon
class AppleIcon extends StatelessWidget {
  final double? size;

  const AppleIcon({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.apple, color: AppColorSchemes.apple, size: size ?? 20.w);
  }
}

// Facebook icon
class FacebookIcon extends StatelessWidget {
  final double? size;

  const FacebookIcon({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 20.w,
      height: size ?? 20.w,
      decoration: const BoxDecoration(
        color: AppColorSchemes.facebook,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'f',
          style: TextStyle(
            fontSize: (size ?? 20.w) * 0.6,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
