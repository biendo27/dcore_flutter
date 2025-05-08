part of '../models.dart';

@freezed
abstract class UserLiveCensor with _$UserLiveCensor {
  const factory UserLiveCensor({
    @Default(0) int id,
    @Default(Live()) Live live,
    @Default(AppUser()) AppUser user,
    @Default([]) List<LiveCensorResultForm> result,
    @Default(0) int point,
    @Default(0) int pointMax,
  }) = _UserLiveCensor;

  factory UserLiveCensor.fromJson(Map<String, dynamic> json) => _$UserLiveCensorFromJson(json);
}
