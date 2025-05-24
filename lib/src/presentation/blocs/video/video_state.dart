part of '../blocs.dart';

@freezed
abstract class VideoState with _$VideoState {
  const factory VideoState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdateController,
    @Default(false) bool isPlaying,
    @Default(0) int currentIndex,
    @Default({}) Map<int, VideoPlayerController> videoControllers,
  }) = _VideoState;

  factory VideoState.initial() => const VideoState();
}
