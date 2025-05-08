part of '../blocs.dart';

@freezed
abstract class RankState with _$RankState {
  const factory RankState({
    @Default(false) bool isLoading,
    @Default(RankConfig()) RankConfig rank,
    @Default(<Rank>[]) List<Rank> rankHistory,
    @Default(Rank()) Rank currentRank,
  }) = _RankState;

  factory RankState.initial() => const RankState();
}
