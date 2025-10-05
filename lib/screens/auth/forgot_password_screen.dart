import 'package:ecommerce_mobile_app/services/auth_service.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        await AuthService.resetPassword(email: _emailController.text.trim());
        
        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Password reset email sent to ${_emailController.text}',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColorSchemes.white,
                ),
              ),
              backgroundColor: AppColorSchemes.success,
            ),
          );
          
          // Navigate back to sign in
          context.pop();
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
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorSchemes.surface,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16.w,
                      color: AppColorSchemes.black,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                
                // Title
                AppText(
                  title: 'Forgot Password',
                  style: AppTypography.pageTitle,
                ),
                SizedBox(height: 16.h),
                
                // Description
                AppText(
                  title: 'Enter Email address',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 32.h),
                
                // Email field
                AppTextField(
                  hint: 'Enter Email address',
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
                SizedBox(height: 32.h),
                
                // Continue button
                AppButton.primary(
                  content: 'Continue',
                  onTap: _handleForgotPassword,
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