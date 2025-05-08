part of '../blocs.dart';

@freezed
abstract class LiveViewerState with _$LiveViewerState {
  const factory LiveViewerState({
    @Default(false) bool isLoading,
    @Default([]) List<AppUser> viewers,
  }) = _LiveViewerState;

  factory LiveViewerState.initial() => LiveViewerState();
}
