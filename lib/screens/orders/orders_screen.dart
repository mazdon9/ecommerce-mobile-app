import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.background,
      appBar: AppBar(
        backgroundColor: AppColorSchemes.background,
        elevation: 0,
        title: Text('Orders', style: AppTypography.pageTitle),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text('Orders Screen\nComing Soon!', textAlign: TextAlign.center, style: AppTypography.bodyLarge),
        ),
      ),
    );
  }
}
