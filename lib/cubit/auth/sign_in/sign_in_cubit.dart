import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_mobile_app/repositories/auth_repository.dart';
import 'package:ecommerce_mobile_app/cubit/auth/sign_in/sign_in_state.dart';

// @Singleton() -> create a singleton instance of the class, create right after app starts
// @LazySingleton() -> create a singleton instance of the class when it is first needed ( when use getIt<Instance>() )
// @injectable -> factory, create a new instance every time when it is needed ( getIt<Instance>() )

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  final AuthRepository _authRepository = getIt<AuthRepository>();
  final AppLogger _logger = getIt<AppLogger>();

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));

    try {
      await _authRepository.signInWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(isSuccess: true));
    } catch (e, stackTrace) {
      _logger.e('Error signing in', error: e, stackTrace: stackTrace);
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// clear api error message
  void clearApiErrorMessage() {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
