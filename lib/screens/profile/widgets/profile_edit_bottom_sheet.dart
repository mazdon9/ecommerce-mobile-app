import 'package:ecommerce_mobile_app/cubit/profile/profile_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/profile/profile_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/theme/app_color_scheme.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileEditBottomSheet extends StatefulWidget {
  const ProfileEditBottomSheet({super.key});

  @override
  State<ProfileEditBottomSheet> createState() => _ProfileEditBottomSheetState();
}

class _ProfileEditBottomSheetState extends State<ProfileEditBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final ProfileState state = getIt<ProfileCubit>().state;
    _firstNameController = TextEditingController(text: state.firstName);
    _lastNameController = TextEditingController(text: state.lastName);
    _emailController = TextEditingController(text: state.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.trim().length < 2) {
      return 'Must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _onUpdatePressed() {
    if (_formKey.currentState?.validate() ?? false) {
      getIt<ProfileCubit>().updateProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      listener: (context, state) {
        if (state.updateSuccessMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.updateSuccessMessage), backgroundColor: AppColorSchemes.primary));

          /// TODO: handle pop only one time
          context.pop();
        }
        if (state.apiErrorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.apiErrorMessage), backgroundColor: AppColorSchemes.error));
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h, bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
          decoration: BoxDecoration(
            color: AppColorSchemes.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Profile',
                      style: AppTypography.pageTitle.copyWith(fontWeight: FontWeight.w600, color: AppColorSchemes.black),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, size: 24.w, color: AppColorSchemes.grey),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildTextField(controller: _firstNameController, label: 'First Name', validator: _validateName, enabled: !state.isUpdating),
                SizedBox(height: 16.h),
                _buildTextField(controller: _lastNameController, label: 'Last Name', validator: _validateName, enabled: !state.isUpdating),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !state.isUpdating,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: state.isUpdating ? null : _onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorSchemes.primary,
                      disabledBackgroundColor: AppColorSchemes.grey.withOpacity(0.3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: state.isUpdating
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppColorSchemes.white)),
                          )
                        : Text(
                            'Update Profile',
                            style: AppTypography.bodyLarge.copyWith(color: AppColorSchemes.white, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500, color: AppColorSchemes.black),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          enabled: enabled,
          style: AppTypography.bodyMedium.copyWith(color: enabled ? AppColorSchemes.black : AppColorSchemes.grey),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? AppColorSchemes.background : AppColorSchemes.grey.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColorSchemes.grey.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColorSchemes.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColorSchemes.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColorSchemes.error),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColorSchemes.grey.withOpacity(0.2)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
      ],
    );
  }
}
