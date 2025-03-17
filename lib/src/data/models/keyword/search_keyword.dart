part of '../models.dart';

@freezed
class SearchKeyword with _$SearchKeyword {
  const factory SearchKeyword({
    @Default(0) int id,
    @Default('') String keyword,
  }) = _SearchKeyword;

  factory SearchKeyword.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordFromJson(json);
}
