import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@freezed
class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String userId,
    @Default('') String createdAt,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);
}

// Extension to provide computed properties
extension UserInfoModelExtension on UserInfoModel {
  /// Get full display name (firstName + lastName)
  String get displayName {
    if (firstName.isEmpty && lastName.isEmpty) {
      return 'User';
    }
    return '$firstName $lastName'.trim();
  }

  /// Check if user info is empty
  bool get isEmpty => firstName.isEmpty && lastName.isEmpty && email.isEmpty;
}
