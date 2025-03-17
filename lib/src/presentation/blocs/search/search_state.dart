part of '../blocs.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(false) bool isLoading,
    @Default([]) List<SearchKeyword> keywords,
    @Default(SearchHistory()) SearchHistory searchHistory,
    @Default('') String currentKeyword,
  }) = _SearchState;

  factory SearchState.initial() => const SearchState();
} 