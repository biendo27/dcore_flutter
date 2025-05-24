part of '../blocs.dart';

@freezed
abstract class HomeSearchState with _$HomeSearchState {
  const factory HomeSearchState({
    @Default(false) bool isLoading,
    @Default('') String keyword,
    @Default(BasePageBreak<Post>()) BasePageBreak<Post> posts,
    @Default(BasePageBreak<AppUser>()) BasePageBreak<AppUser> users,
  }) = _HomeSearchState;

  factory HomeSearchState.initial() => HomeSearchState();
}
