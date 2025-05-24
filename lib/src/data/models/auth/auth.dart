part of '../models.dart';

@freezed
abstract class Auth with _$Auth {
  const factory Auth({
    @Default('') String accessToken,
    @Default(AppUser()) AppUser user,
  }) = _Auth;

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
}
