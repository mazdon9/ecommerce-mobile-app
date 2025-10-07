import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/models/responses/user_info_model.dart';
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserRepository {
  UserRepository(this._firebaseService, this._logger);

  final FirebaseService _firebaseService;
  final AppLogger _logger;

  // Fetch current user info
  Future<UserInfoModel?> getCurrentUserInfo() async {
    try {
      return await _firebaseService.getCurrentUserInfo();
    } catch (e, stackTrace) {
      _logger.e('Error fetching current user info', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Update user info
  Future<void> updateUserInfo({required String firstName, required String lastName, required String email}) async {
    try {
      await _firebaseService.updateUserInfo(firstName: firstName, lastName: lastName, email: email);
      _logger.i('User info updated successfully');
    } catch (e, stackTrace) {
      _logger.e('Error updating user info', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
