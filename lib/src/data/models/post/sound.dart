part of '../models.dart';

@freezed
abstract class Sound with _$Sound {
  const factory Sound({
    @Default(0) int id,
    @Default('') String audio,
    @Default(0) int duration,
    @Default('') String singer,
    @Default('') String image,
    @Default('') String title,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(null) DateTime? deletedAt,
    @Default(0) int postUsedCount,
    @Default(false) bool isBookmarkedByUser,
    @Default(AppUser()) AppUser user,
    @Default([]) List<Post> posts,
  }) = _Sound;

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);
}

extension SoundX on Sound {
  String displayTitle(BuildContext context) {
    return title.isEmpty ? context.text.originalAudio : title;
  }
}
