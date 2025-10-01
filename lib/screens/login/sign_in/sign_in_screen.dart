import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                _buildHeader(),
                SizedBox(height: 40.h),
                _buildEmailField(),
                SizedBox(height: 30.h),
                _buildPasswordField(),
                SizedBox(height: 20.h),
                _buildForgotPasswordLink(),
                SizedBox(height: 30.h),
                _buildSignInButton(),
                SizedBox(height: 25.h),
                _buildCreateAccountLink(),
                SizedBox(height: 40.h),
                _buildSocialLoginOptions(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: 'Sign in', style: AppTypography.textFont26W600),
        SizedBox(height: 16.h),
        AppText(
          title: 'Enter your email and password',
          style: AppTypography.textFont16W500.copyWith(
            color: AppColorSchemes.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return AppTextField(
      label: 'Email',
      hint: 'Enter your email address',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget _buildPasswordField() {
    return AppTextField(
      label: 'Password',
      hint: 'Enter your password',
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: AppColorSchemes.grey,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: _handleForgotPassword,
        child: AppText(
          title: 'Forgot Password?',
          style: AppTypography.textFont14W500.copyWith(
            color: AppColorSchemes.green,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return AppButton(
      content: _isLoading ? 'Signing in...' : 'Continue',
      onTap: _isLoading ? () {} : _handleSignIn,
      backgroundColor: _canSignIn()
          ? AppColorSchemes.green
          : AppColorSchemes.grey,
      width: double.infinity,
    );
  }

  Widget _buildCreateAccountLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          title: "Don't have an Account? ",
          style: AppTypography.textFont14W500.copyWith(
            color: AppColorSchemes.black,
          ),
        ),
        GestureDetector(
          onTap: _handleCreateAccount,
          child: AppText(
            title: 'Create One',
            style: AppTypography.textFont14W500.copyWith(
              color: AppColorSchemes.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginOptions() {
    return Column(
      children: [
        _buildSocialLoginButton(
          title: 'Continue With Apple',
          iconPath: 'assets/icons/apple_icon.png',
          onTap: _handleAppleSignIn,
        ),
        SizedBox(height: 16.h),
        _buildSocialLoginButton(
          title: 'Continue With Google',
          iconPath: 'assets/icons/google_icon.png',
          onTap: _handleGoogleSignIn,
        ),
        SizedBox(height: 16.h),
        _buildSocialLoginButton(
          title: 'Continue With Facebook',
          iconPath: 'assets/icons/facebook_icon.png',
          onTap: _handleFacebookSignIn,
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return AppButton(
      content: title,
      onTap: onTap,
      backgroundColor: AppColorSchemes.white,
      borderColors: Border.all(
        color: AppColorSchemes.grey.withOpacity(0.3),
        width: 1,
      ),
      iconPath: iconPath,
      textStyle: AppTypography.textFont18W600.copyWith(
        color: AppColorSchemes.black,
      ),
    );
  }

  // Helper methods
  bool _canSignIn() {
    return _emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        _isValidEmail(_emailController.text.trim());
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Action handlers
  void _handleSignIn() {
    if (!_canSignIn()) {
      _showErrorDialog('Please enter valid email and password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement sign in logic
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      // TODO: Navigate to home screen on success
      _showSuccessDialog('Sign in successful!');
    });
  }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
    debugPrint('Navigate to forgot password screen');
  }

  void _handleCreateAccount() {
    // TODO: Navigate to sign up screen
    debugPrint('Navigate to sign up screen');
  }

  void _handleAppleSignIn() {
    // TODO: Implement Apple sign in
    debugPrint('Apple sign in tapped');
  }

  void _handleGoogleSignIn() {
    // TODO: Implement Google sign in
    debugPrint('Google sign in tapped');
  }

  void _handleFacebookSignIn() {
    // TODO: Implement Facebook sign in
    debugPrint('Facebook sign in tapped');
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
