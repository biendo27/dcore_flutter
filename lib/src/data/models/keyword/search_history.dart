part of '../models.dart';

@freezed
abstract class SearchHistory with _$SearchHistory {
  const factory SearchHistory({
    @Default([]) List<SearchKeyword> histories,
    @Default([]) List<Product> products,
  }) = _SearchHistory;

  factory SearchHistory.fromJson(Map<String, dynamic> json) => _$SearchHistoryFromJson(json);
}
