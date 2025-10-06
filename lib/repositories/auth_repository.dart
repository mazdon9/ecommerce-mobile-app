import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthRepository {
  AuthRepository(this._firebaseService, this._logger);

  final FirebaseService _firebaseService;
  final AppLogger _logger;

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseService.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, stackTrace) {
      _logger.e('Error signing in', error: e, stackTrace: stackTrace);
      rethrow; // Rethrow the exception after logging it
    }
  }

  // Create user with email and password
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _firebaseService.createUserWithEmailAndPassword(email: email, password: password, firstName: firstName, lastName: lastName);
    } catch (e, stackTrace) {
      _logger.e('Error creating user', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
