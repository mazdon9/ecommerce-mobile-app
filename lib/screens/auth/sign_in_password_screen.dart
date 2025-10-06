import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/auth/widgets/widgets.dart';
import 'package:ecommerce_mobile_app/services/auth_service.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInPasswordScreen extends StatefulWidget {
  final String email;

  const SignInPasswordScreen({super.key, required this.email});

  @override
  State<SignInPasswordScreen> createState() => _SignInPasswordScreenState();
}

class _SignInPasswordScreenState extends State<SignInPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await AuthService.signInWithEmailAndPassword(
          email: widget.email,
          password: _passwordController.text,
        );

        if (mounted) {
          // Navigate to dashboard
          context.go(RouteName.dashboardPath);
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
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
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
                SizedBox(height: 20.h),

                // Back button
                const AuthBackButton(),
                SizedBox(height: 24.h),

                // Title
                const AuthPageTitle(title: 'Sign in'),
                SizedBox(height: 40.h),

                // Password field
                AuthPasswordField(controller: _passwordController),
                SizedBox(height: 12.h),

                // Forgot password link
                AuthForgotPasswordLink(
                  onTap: () => context.push(RouteName.forgotPasswordPath),
                ),
                SizedBox(height: 32.h),

                // Continue button
                AppButton.primary(
                  content: 'Continue',
                  onTap: _handleSignIn,
                  isLoading: _isLoading,
                  isEnabled: !_isLoading,
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
