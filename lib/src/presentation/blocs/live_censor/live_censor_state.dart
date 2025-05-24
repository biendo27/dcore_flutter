part of '../blocs.dart';

@freezed
abstract class LiveCensorState with _$LiveCensorState {
  const factory LiveCensorState({
    @Default(false) bool isLoading,
    @Default([]) List<LiveCensorForm> censorForms,
    @Default(UserLiveCensor()) UserLiveCensor currentCensorResult,
  }) = _LiveCensorState;

  factory LiveCensorState.initial() => const LiveCensorState();
}

extension LiveCensorStateX on LiveCensorState {
  int get censorLength => censorForms.fold(0, (previous, element) => previous + element.data.length);
  int get censorResultLength => currentCensorResult.result.fold(0, (previous, element) => previous + element.data.length);
}
