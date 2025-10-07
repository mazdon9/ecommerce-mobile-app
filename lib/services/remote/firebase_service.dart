import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/models/responses/user_info_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FirebaseService {
  FirebaseService(this._auth, this._logger, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final AppLogger _logger;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  // Create user with email and password
  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      // create user with email password
      final UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // save user info to firestore
      await _firestore.collection('users').doc(result.user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'userId': result.user?.uid,
        'createdAt': DateTime.now().toIso8601String(),
      });

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      _logger.e('Error creating user', error: e, stackTrace: stackTrace);
      throw 'An unexpected error occurred';
    }
  }

  // Get current user info from Firestore
  Future<UserInfoModel?> getCurrentUserInfo() async {
    try {
      final User? user = currentUser;
      if (user == null) {
        throw 'No authenticated user found';
      }

      final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists || userDoc.data() == null) {
        _logger.w('User document not found for userId: ${user.uid}');
        return null;
      }

      return UserInfoModel.fromJson(userDoc.data()!);
    } catch (e, stackTrace) {
      _logger.e('Error fetching current user info', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Update user info in Firestore
  Future<void> updateUserInfo({required String firstName, required String lastName, required String email}) async {
    try {
      final User? user = currentUser;
      if (user == null) {
        throw 'No authenticated user found';
      }

      // Update email in Firebase Auth if it's different
      if (user.email != email) {
        await user.verifyBeforeUpdateEmail(email);
      }

      // Update user info in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      _logger.i('User info updated successfully for userId: ${user.uid}');
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      _logger.e('Error updating user info', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Sign in to Firebase with the Google user credential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Failed to sign in with Google';
    }
  }

  // Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Failed to send password reset email';
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      throw 'Failed to sign out';
    }
  }

  // Handle Firebase Auth exceptions
  static String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'Email address is already in use';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'too-many-requests':
        return 'Too many requests. Please try again later';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support';
      default:
        return e.message ?? 'An error occurred';
    }
  }
}
