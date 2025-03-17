part of '../blocs.dart';

@freezed
class LiveEventState with _$LiveEventState {
  const factory LiveEventState({
    @Default(false) bool isLoading,
    @Default(BasePageBreak<Live>()) BasePageBreak<Live> liveEvent,
  }) = _LiveEventState;

  factory LiveEventState.initial() => LiveEventState();
}
