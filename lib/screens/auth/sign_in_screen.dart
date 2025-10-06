import 'package:ecommerce_mobile_app/cubit/auth/sign_in/sign_in_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/auth/sign_in/sign_in_state.dart';
import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/auth/widgets/widgets.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/shared/common_dialogs.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SignInCubit(), child: const SignInView());
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
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
                    SizedBox(height: 40.h),

                    // Title
                    const AuthPageTitle(title: 'Sign in'),
                    SizedBox(height: 40.h),

                    // Email field only
                    AppTextField(controller: _emailController, hint: 'Enter Email address'),
                    SizedBox(height: 32.h),

                    // Password field only
                    AppTextField(controller: _passwordController, hint: 'Enter Password'),
                    SizedBox(height: 32.h),

                    // Continue button
                    AppButton.primary(
                      content: 'Continue',
                      onTap: () {
                        context.read<SignInCubit>().signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      },
                    ),
                    SizedBox(height: 32.h),

                    // Don't have account section
                    AuthBottomLink(question: "Don't have an account? ", actionText: 'Create One', onTap: () => context.push(RouteName.signUpPath)),
                    SizedBox(height: 40.h),

                    // Social sign in buttons
                    AuthSocialSection(onSocialSignIn: (value) {}),

                    const Spacer(),
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
              onTap: () => context.read<SignInCubit>().clearApiErrorMessage(),
            );
          }
          if (state.isSuccess) {
            context.go(RouteName.dashboardPath);
          }
        }
      },
    );
  }
}
