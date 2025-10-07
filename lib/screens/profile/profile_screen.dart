import 'package:ecommerce_mobile_app/cubit/profile/profile_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/profile/profile_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/profile/widgets/profile_edit_bottom_sheet.dart';
import 'package:ecommerce_mobile_app/screens/profile/widgets/profile_menu_item.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<ProfileCubit>()..fetchUserProfile(), child: const ProfileView());
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.apiErrorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.apiErrorMessage), backgroundColor: AppColorSchemes.error));
          context.read<ProfileCubit>().clearApiErrorMessage();
        }
        if (state.updateSuccessMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.updateSuccessMessage), backgroundColor: AppColorSchemes.primary));
          context.read<ProfileCubit>().clearUpdateSuccessMessage();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorSchemes.background,
          body: SafeArea(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: AppColorSchemes.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [BoxShadow(color: AppColorSchemes.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 80.w,
                                height: 80.w,
                                decoration: BoxDecoration(color: AppColorSchemes.primary.withOpacity(0.1), shape: BoxShape.circle),
                                child: Icon(Icons.person, size: 40.w, color: AppColorSchemes.primary),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        context.read<ProfileCubit>().displayName,
                                        style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600, color: AppColorSchemes.black),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        state.email.isNotEmpty ? state.email : 'No email available',
                                        style: AppTypography.bodyMedium.copyWith(color: AppColorSchemes.grey),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (BuildContext context) => const ProfileEditBottomSheet(),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColorSchemes.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [BoxShadow(color: AppColorSchemes.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
                            ),
                            child: Column(
                              children: [
                                ProfileMenuItem(title: 'Address', onTap: () {}),
                                ProfileMenuItem(title: 'Wishlist', onTap: () {}),
                                ProfileMenuItem(title: 'Payment', onTap: () {}),
                                ProfileMenuItem(title: 'Help', onTap: () {}),
                                ProfileMenuItem(title: 'Support', onTap: () {}, showDivider: false),
                                SizedBox(height: 32.h),
                                GestureDetector(
                                  onTap: () async {
                                    await context.read<ProfileCubit>().signOut();
                                    if (context.mounted) {
                                      context.go(RouteName.signInPath);
                                    }
                                  },
                                  child: Text(
                                    'Sign Out',
                                    style: AppTypography.bodyLarge.copyWith(color: AppColorSchemes.error, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
