part of '../blocs.dart';

@freezed
abstract class SoundState with _$SoundState {
  const factory SoundState({
    @Default(false) bool isLoading,
    @Default(false) bool isPlaying,
    @Default(BasePageBreak<Sound>()) BasePageBreak<Sound> suggestedSounds,
    @Default(BasePageBreak<Sound>()) BasePageBreak<Sound> bookmarkedSounds,
    @Default([]) List<Sound> userSounds,
    @Default(Sound()) Sound currentSound,
  }) = _SoundState;

  factory SoundState.initial() => SoundState();

  factory SoundState.fromJson(Map<String, dynamic> json) => _$SoundStateFromJson(json);
}
