part of '../blocs.dart';

@lazySingleton
class ModerationCubit extends Cubit<ModerationState> with CubitActionMixin<ModerationState> {
  final IModerationRepository _moderationRepository;

  ModerationCubit(this._moderationRepository) : super(ModerationState.initial());

  Future<bool> checkVideoBelowOneMinute(File video) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    ModerationResponse response = await _moderationRepository.checkVideoBelowOneMinute(video);
    return response.status == 'success';
  }

  Future<bool> checkVideoAboveOneMinute(File video) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    ModerationResponse response = await _moderationRepository.checkVideoAboveOneMinute(video);
    return response.status == 'success';
  }

  Future<bool> checkVideo(File video) async {
    bool moderationResult = false;
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final MediaInfo mediaInfo = await VideoCompress.getMediaInfo(video.path);
      final duration = mediaInfo.duration ?? 0;

      if (duration <= 60000) {
        // duration is in milliseconds
        moderationResult = await checkVideoBelowOneMinute(video);
      } else {
        moderationResult = await checkVideoAboveOneMinute(video);
      }

      emit(state.copyWith(isLoading: false, errorMessage: moderationResult ? null : 'Video moderation failed'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      moderationResult = false;
    }
    return moderationResult;
  }

  void reset() {
    emit(ModerationState.initial());
  }
}
