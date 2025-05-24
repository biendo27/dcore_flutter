part of '../blocs.dart';

@freezed
abstract class UserListState with _$UserListState {
  const factory UserListState({
    @Default(false) bool isLoading,
    @Default(0) int pageIndex,
    @Default(BasePageBreak<AppUser>()) BasePageBreak<AppUser> suggestUser,
    @Default(BasePageBreak<AppUser>()) BasePageBreak<AppUser> followerUser,
    @Default(BasePageBreak<AppUser>()) BasePageBreak<AppUser> followingUser,
    @Default(BasePageBreak<AppUser>()) BasePageBreak<AppUser> friendUser,
  }) = _UserListState;

  factory UserListState.initial() => UserListState();
  factory UserListState.fromJson(Map<String, dynamic> json) => _$UserListStateFromJson(json);
}
