import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/auth/widgets/widgets.dart';
import 'package:ecommerce_mobile_app/services/auth_service.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // Navigate to password screen with email
      context.push(
        '${RouteName.signInPasswordPath}?email=${_emailController.text.trim()}',
      );
    }
  }

  void _handleSocialSignIn(String provider) async {
    try {
      if (provider == 'Google') {
        await AuthService.signInWithGoogle();
        if (mounted) {
          context.go(RouteName.dashboardPath);
        }
      } else {
        // TODO: Implement Apple and Facebook sign in
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$provider sign in coming soon'),
              backgroundColor: AppColorSchemes.info,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColorSchemes.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                // Title
                const AuthPageTitle(title: 'Sign in'),
                SizedBox(height: 40.h),

                // Email field only
                AuthEmailField(controller: _emailController),
                SizedBox(height: 32.h),

                // Continue button
                AppButton.primary(content: 'Continue', onTap: _handleContinue),
                SizedBox(height: 32.h),

                // Don't have account section
                AuthBottomLink(
                  question: "Don't have an Account? ",
                  actionText: 'Create One',
                  onTap: () => context.push(RouteName.signUpPath),
                ),
                SizedBox(height: 40.h),

                // Social sign in buttons
                AuthSocialSection(onSocialSignIn: _handleSocialSignIn),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
