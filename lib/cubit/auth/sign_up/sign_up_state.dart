import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({@Default(false) bool isLoading, @Default(false) bool isSuccess, @Default('') String apiErrorMessage}) = _SignUpState;
}
