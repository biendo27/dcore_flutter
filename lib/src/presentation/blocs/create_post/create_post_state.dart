part of '../blocs.dart';

@freezed
abstract class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    @Default(false) bool isLoading,
    @Default('') String videoPath,
    @Default('') String mergedVideoPath,
    @Default('') String title,
    @Default('') String description,
    @Default(true) bool allowComments,
    @Default(true) bool allowDownload,
    @Default(LocaleType.vi) LocaleType selectedLanguage,
    @Default('') String thumbnailPath,
    @Default('') String errorMessage,
    @Default(Sound()) Sound selectedSound,
    @Default([]) List<HashTag> hashtags,
    @Default([]) List<Product> products,
    Product? selectedProduct,
    @Default(null) void Function(String videoPath)? onVideoReady,
  }) = _CreatePostState;

  factory CreatePostState.initial() => CreatePostState();
}

extension CreatePostStateX on CreatePostState {
  bool get hasSelectedSound => selectedSound.id != 0;
  String get selectedSoundName {
    if (!hasSelectedSound) return AppConfig.context!.text.addSound;

    return selectedSound.title;
  }
}
