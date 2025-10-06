import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_mobile_app/repositories/auth_repository.dart';
import 'package:ecommerce_mobile_app/cubit/auth/sign_up/sign_up_state.dart';

// @Singleton() -> create a singleton instance of the class, create right after app starts
// @LazySingleton() -> create a singleton instance of the class when it is first needed ( when use getIt<Instance>() )
// @injectable -> factory, create a new instance every time when it is needed ( getIt<Instance>() )

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  final AuthRepository _authRepository = getIt<AuthRepository>();
  final AppLogger _logger = getIt<AppLogger>();

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));

    try {
      await _authRepository.createUserWithEmailAndPassword(email: email, password: password, firstName: firstName, lastName: lastName);
      emit(state.copyWith(isSuccess: true));
    } catch (e, stackTrace) {
      _logger.e('Error creating user', error: e, stackTrace: stackTrace);
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
