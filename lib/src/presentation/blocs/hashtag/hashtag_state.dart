part of '../blocs.dart';

@freezed
abstract class HashtagState with _$HashtagState {
  const factory HashtagState({
    @Default(false) bool isLoading,
    @Default(BasePageBreak<HashTag>()) BasePageBreak<HashTag> hashtags,
    @Default('') String searchQuery,
  }) = _HashtagState;

  factory HashtagState.initial() => HashtagState();
}
