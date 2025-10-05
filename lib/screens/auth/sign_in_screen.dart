import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/services/auth_service.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/shared/social_icons.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
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
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
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
          email: _emailController.text.trim(),
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

  void _handleSocialSignIn(String provider) async {
    try {
      setState(() {
        _isLoading = true;
      });

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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
                AppText(
                  title: 'Sign in',
                  style: AppTypography.pageTitle,
                ),
                SizedBox(height: 40.h),
                
                // Email field
                AppTextField(
                  hint: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                
                // Password field
                AppTextField(
                  hint: 'Password',
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible 
                          ? Icons.visibility_off 
                          : Icons.visibility,
                      color: AppColorSchemes.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                
                // Forgot password link
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.push(RouteName.forgotPasswordPath),
                    child: AppText(
                      title: 'Forgot Password?',
                      style: AppTypography.linkText,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                
                // Continue button
                AppButton.primary(
                  content: 'Continue',
                  onTap: _handleSignIn,
                  isLoading: _isLoading,
                  isEnabled: !_isLoading,
                ),
                SizedBox(height: 32.h),
                
                // Don't have account section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title: "Don't have an Account? ",
                      style: AppTypography.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () => context.push(RouteName.signUpPath),
                      child: AppText(
                        title: 'Create One',
                        style: AppTypography.linkText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                
                // Social sign in buttons
                AppButton.social(
                  content: 'Continue With Apple',
                  icon: const AppleIcon(),
                  onTap: () => _handleSocialSignIn('Apple'),
                ),
                SizedBox(height: 16.h),
                
                AppButton.social(
                  content: 'Continue With Google',
                  icon: const GoogleIcon(),
                  onTap: () => _handleSocialSignIn('Google'),
                ),
                SizedBox(height: 16.h),
                
                AppButton.social(
                  content: 'Continue With Facebook',
                  icon: const FacebookIcon(),
                  onTap: () => _handleSocialSignIn('Facebook'),
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