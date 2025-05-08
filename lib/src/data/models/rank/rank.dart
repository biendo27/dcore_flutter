part of '../models.dart';

@freezed
abstract class Rank with _$Rank {
  const factory Rank({
    @Default(0) int id,
    @Default('') String image,
    @Default('') String name,
    @Default('') String description,
    @Default(0) int videoRequired,
    @Default(0) int moneyRequired,
    @Default(null) DateTime? createdAt,
    @Default(0) int level,
  }) = _Rank;

  factory Rank.fromJson(Map<String, dynamic> json) => _$RankFromJson(json);
}
