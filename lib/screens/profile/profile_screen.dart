import 'package:ecommerce_mobile_app/cubit/profile/profile_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/profile/profile_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/profile/widgets/avatar_options_bottom_sheet.dart';
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
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..fetchUserProfile(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.apiErrorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.apiErrorMessage),
              backgroundColor: AppColorSchemes.error,
            ),
          );
          context.read<ProfileCubit>().clearApiErrorMessage();
        }
        if (state.updateSuccessMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.updateSuccessMessage),
              backgroundColor: AppColorSchemes.primary,
            ),
          );
          context.read<ProfileCubit>().clearUpdateSuccessMessage();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorSchemes.background,
          body: SafeArea(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        // Profile Header Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: AppColorSchemes.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColorSchemes.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Avatar with tap functionality
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) =>
                                        const AvatarOptionsBottomSheet(),
                                  );
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 100.w,
                                  decoration: BoxDecoration(
                                    color: AppColorSchemes.grey.withOpacity(
                                      0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/avatar_placeholder.png', // Replace with actual avatar
                                      width: 100.w,
                                      height: 100.w,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(
                                              Icons.person,
                                              size: 50.w,
                                              color: AppColorSchemes.grey,
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // User Info and Edit Button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context
                                              .read<ProfileCubit>()
                                              .displayName,
                                          style: AppTypography.pageTitle
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColorSchemes.black,
                                              ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          state.email.isNotEmpty
                                              ? state.email
                                              : 'No email available',
                                          style: AppTypography.bodyMedium
                                              .copyWith(
                                                color: AppColorSchemes.grey,
                                              ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          '121-224-7890', // Phone number placeholder
                                          style: AppTypography.bodyMedium
                                              .copyWith(
                                                color: AppColorSchemes.grey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (BuildContext context) =>
                                            const ProfileEditBottomSheet(),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColorSchemes.primary
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Text(
                                        'Edit',
                                        style: AppTypography.linkText.copyWith(
                                          color: AppColorSchemes.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Menu Items
                        ProfileMenuItem(
                          title: 'Address',
                          onTap: () {
                            // TODO: Navigate to address screen
                          },
                        ),
                        ProfileMenuItem(
                          title: 'Wishlist',
                          onTap: () {
                            // TODO: Navigate to wishlist screen
                          },
                        ),
                        ProfileMenuItem(
                          title: 'Payment',
                          onTap: () {
                            // TODO: Navigate to payment screen
                          },
                        ),
                        ProfileMenuItem(
                          title: 'Help',
                          onTap: () {
                            // TODO: Navigate to help screen
                          },
                        ),
                        ProfileMenuItem(
                          title: 'Support',
                          onTap: () {
                            // TODO: Navigate to support screen
                          },
                        ),

                        SizedBox(height: 32.h),

                        // Sign Out Button
                        GestureDetector(
                          onTap: () async {
                            await context.read<ProfileCubit>().signOut();
                            if (context.mounted) {
                              context.go(RouteName.signInPath);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Center(
                              child: Text(
                                'Sign Out',
                                style: AppTypography.bodyLarge.copyWith(
                                  color: AppColorSchemes.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
