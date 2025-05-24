part of '../blocs.dart';

@lazySingleton
class SoundCubit extends HydratedCubit<SoundState> with CubitActionMixin<SoundState> {
  final ISoundRepository _soundRepository = AppDI.source.get<ISoundRepository>();
  SoundCubit() : super(SoundState.initial());

  @override
  SoundState fromJson(Map<String, dynamic> json) => SoundState.fromJson(json);

  @override
  Map<String, dynamic> toJson(SoundState state) => state.toJson();

  void setAudioPlaying(bool isPlaying) => emit(state.copyWith(isPlaying: isPlaying));
  void setCurrentSound(Sound sound) => emit(state.copyWith(currentSound: sound));

  void initSoundList() {
    fetchSoundSuggestedList(isInit: true);
    fetchSoundBookmarked(isInit: true);
  }

  Future<void> fetchSoundSuggestedList({String search = '', bool isInit = false}) async {
    if (state.suggestedSounds.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.suggestedSounds.nextPage;
    executePageBreakAction(
      isInit: isInit,
      action: () => _soundRepository.fetchSoundSuggestedList(search, page),
      currentPageData: state.suggestedSounds,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(suggestedSounds: mergedPageBreakData),
    );
  }

  Future<void> fetchSoundBookmarked({String search = '', bool isInit = false}) async {
    if (state.bookmarkedSounds.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.bookmarkedSounds.nextPage;
    executePageBreakAction(
      isInit: isInit,
      action: () => _soundRepository.fetchSoundBookmarked(search, page),
      currentPageData: state.bookmarkedSounds,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(bookmarkedSounds: mergedPageBreakData),
    );
  }

  Future<void> fetchSoundDetail(int soundId) async {
    executeAction(
      action: () => _soundRepository.fetchSoundDetail(soundId),
      onSuccess: (response) => emit(state.copyWith(currentSound: response.data!)),
    );
  }

  Future<void> updateBookmarkSound(int soundId) async {
    executeEmptyAction(
      action: () => _soundRepository.updateBookmarkSound(soundId),
      onSuccess: (response) {
        Sound currentSound = state.currentSound;
        currentSound = currentSound.copyWith(isBookmarkedByUser: !currentSound.isBookmarkedByUser);
        emit(state.copyWith(currentSound: currentSound));
      },
    );
  }
}
