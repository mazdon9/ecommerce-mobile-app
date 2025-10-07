import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/models/responses/user_info_model.dart';
import 'package:ecommerce_mobile_app/repositories/user_repository.dart';
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_mobile_app/cubit/profile/profile_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository, this._firebaseService, this._logger) : super(const ProfileState());

  final UserRepository _userRepository;
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  /// Fetch current user profile data
  Future<void> fetchUserProfile() async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));

    try {
      final UserInfoModel? userInfo = await _userRepository.getCurrentUserInfo();

      if (userInfo != null) {
        emit(state.copyWith(firstName: userInfo.firstName, lastName: userInfo.lastName, email: userInfo.email, userId: userInfo.userId));
      } else {
        emit(state.copyWith(apiErrorMessage: 'User data not found'));
      }
    } catch (e, stackTrace) {
      _logger.e('Error fetching user profile', error: e, stackTrace: stackTrace);
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));

    try {
      await _firebaseService.signOut();
      // Reset state after sign out
      emit(const ProfileState());
    } catch (e, stackTrace) {
      _logger.e('Error signing out', error: e, stackTrace: stackTrace);
      emit(state.copyWith(apiErrorMessage: e.toString(), isLoading: false));
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    emit(state.copyWith(isUpdating: true, apiErrorMessage: '', updateSuccessMessage: ''));

    try {
      await _userRepository.updateUserInfo(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );

      // Update local state with new values
      emit(state.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        updateSuccessMessage: 'Profile updated successfully',
      ));
    } catch (e, stackTrace) {
      _logger.e('Error updating profile', error: e, stackTrace: stackTrace);
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isUpdating: false));
    }
  }

  /// Clear error message
  void clearApiErrorMessage() {
    emit(state.copyWith(apiErrorMessage: ''));
  }

  /// Clear success message
  void clearUpdateSuccessMessage() {
    emit(state.copyWith(updateSuccessMessage: ''));
  }

  /// Get display name (first + last name) from current state
  String get displayName {
    final firstName = state.firstName;
    final lastName = state.lastName;

    if (firstName.isEmpty && lastName.isEmpty) {
      return 'User';
    }

    return '$firstName $lastName'.trim();
  }
}
