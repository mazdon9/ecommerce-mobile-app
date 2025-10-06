import 'package:ecommerce_mobile_app/cubit/auth/sign_up/sign_up_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/auth/sign_up/sign_up_state.dart';
import 'package:ecommerce_mobile_app/screens/auth/widgets/widgets.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/shared/common_dialogs.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SignUpCubit(), child: const SignUpView());
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      builder: (context, state) {
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
                    AppTextField(
                      controller: _emailController,
                      hint: 'Enter Email address',
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
                      controller: _passwordController,
                      hint: 'Enter Password',
                      obscureText: true,
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
                    SizedBox(height: 40.h),

                    // Continue button
                    AppButton.primary(
                      content: 'Continue',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignUpCubit>().createUserWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                          );
                        }
                      },
                    ),

                    const Spacer(),

                    // Already have account section
                    AuthBottomLink(question: "Already have an Account? ", actionText: 'Sign In', onTap: () => context.pop()),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.isLoading) {
          CommonDialogs.showLoadingDialog(context);
        } else {
          CommonDialogs.hideLoadingDialog(context);
          if (state.apiErrorMessage.isNotEmpty) {
            CommonDialogs.showErrorDialog(
              context: context,
              message: state.apiErrorMessage,
              onTap: () => context.read<SignUpCubit>().clearApiErrorMessage(),
            );
          }
          if (state.isSuccess) {
            // Navigate back to sign in screen
            context.pop();
          }
        }
      },
    );
  }
}
