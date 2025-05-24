part of '../blocs.dart';

@freezed
abstract class CameraState with _$CameraState {
  const factory CameraState({
    @Default(FlashMode.off) FlashMode flashMode,
    @Default(CameraLensDirection.back) CameraLensDirection lensDirection,
    @Default(CameraMode.video) CameraMode mode,
    @Default(false) bool isRecording,
    @Default('') String errorMessage,
    @Default(Duration(seconds: 10)) Duration recordDuration,
    @Default(0.0) double recordingProgress,
    @Default(false) bool hasRecordedVideo,
    @Default('') String recordedVideoPath,
    @Default(false) bool isInitialized,
  }) = _CameraState;

  factory CameraState.initial() => const CameraState();
}

enum CameraMode { photo, video }

extension CameraStateX on CameraState {}
