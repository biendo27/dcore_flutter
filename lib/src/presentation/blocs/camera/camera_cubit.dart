part of '../blocs.dart';

@lazySingleton
class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraState.initial());

  void reset() {
    emit(CameraState.initial());
  }

  void setInitialized(bool isInitialized) {
    emit(state.copyWith(isInitialized: isInitialized));
  }

  void switchMode() {
    emit(state.copyWith(
      mode: state.mode == CameraMode.photo ? CameraMode.video : CameraMode.photo,
    ));
  }

  void toggleFlash() {
    FlashMode flashMode = state.flashMode == FlashMode.off ? FlashMode.always : FlashMode.off;
    emit(state.copyWith(flashMode: flashMode));
  }

  void switchCamera() { 
    CameraLensDirection lensDirection = state.lensDirection == CameraLensDirection.back ? CameraLensDirection.front : CameraLensDirection.back;
    emit(state.copyWith(lensDirection: lensDirection));
  }

  void startRecording(CameraController controller) {
    emit(state.copyWith(
      isRecording: true,
      recordingProgress: 0.0,
      errorMessage: '',
    ));
    _updateRecordingProgress(controller);
  }

  void stopRecording(String videoPath) {
    emit(state.copyWith(
      isRecording: false,
      hasRecordedVideo: true,
      recordedVideoPath: videoPath,
      recordingProgress: 1.0,
    ));
    DNavigator.goNamed(RouteNamed.videoPreview);
  }

  void _updateRecordingProgress(CameraController controller) {
    final totalMilliseconds = state.recordDuration.inMilliseconds;
    for (int i = 1; i <= totalMilliseconds ~/ 100; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (state.isRecording) {
          final progress = i * 100 / totalMilliseconds;
          emit(state.copyWith(recordingProgress: progress));

          if (progress >= 1.0) {
            _autoStopRecording(controller);
          }
        }
      });
    }
  }

  Future<void> _autoStopRecording(CameraController controller) async {
    if (state.isRecording) {
      try {
        final videoPath = await CameraService.stopVideoRecording(controller);
        stopRecording(videoPath);
      } catch (e) {
        setErrorMessage('Failed to stop recording: $e');
      }
    }
  }

  void discardRecordedVideo() {
    showDYesNoDialog(
      message: 'Bạn có muốn hủy bỏ video đã ghi không?',
      onYes: () {
        emit(state.copyWith(
          hasRecordedVideo: false,
          recordedVideoPath: '',
        ));
        DNavigator.back();
        DNavigator.back();
      },
      onNo: DNavigator.back,
    );
  }

  void setRecordDuration(Duration duration) {
    emit(state.copyWith(recordDuration: duration));
  }

  void setErrorMessage(String message) {
    emit(state.copyWith(errorMessage: message));
  }

  // Add this new method for gallery videos
  void setGalleryVideo(String videoPath) {
    emit(state.copyWith(
      isRecording: false,
      hasRecordedVideo: true,
      recordedVideoPath: videoPath,
      recordingProgress: 1.0,
    ));
    DNavigator.goNamed(RouteNamed.videoPreview);
  }
}
