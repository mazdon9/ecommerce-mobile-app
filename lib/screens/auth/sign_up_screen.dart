import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/auth/widgets/widgets.dart';
import 'package:ecommerce_mobile_app/services/auth_service.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await AuthService.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
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
                const AuthPageTitle(title: 'Create Account'),
                SizedBox(height: 32.h),

                // First name field
                AppTextField(
                  hint: 'Firstname',
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Last name field
                AppTextField(
                  hint: 'Lastname',
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Email field
                AuthEmailField(controller: _emailController),
                SizedBox(height: 20.h),

                // Password field
                AuthPasswordField(controller: _passwordController),
                SizedBox(height: 12.h),

                // Forgot password link

                // Continue button
                SizedBox(height: 40.h),
                AppButton.primary(
                  content: 'Continue',
                  onTap: _handleSignUp,
                  isLoading: _isLoading,
                  isEnabled: !_isLoading,
                ),
                SizedBox(height: 40.h),
                AuthForgotPasswordLink(
                  onTap: () => context.push(RouteName.forgotPasswordPath),
                ),

                const Spacer(),

                // Already have account section
                AuthBottomLink(
                  question: "Already have an Account? ",
                  actionText: 'Sign In',
                  onTap: () => context.pop(),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
