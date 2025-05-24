part of '../models.dart';

@freezed
abstract class RankConfig with _$RankConfig {
  const factory RankConfig({
    @Default(Rank()) Rank rank,
    @Default([]) List<Rank> ranks,
  }) = _RankConfig;

  factory RankConfig.fromJson(Map<String, dynamic> json) => _$RankConfigFromJson(json);
}
