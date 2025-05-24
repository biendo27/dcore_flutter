part of '../models.dart';

@freezed
abstract class AppFile with _$AppFile {
  const factory AppFile({
    @Default('') String url,
    @Default('') String fileName,
    @Default('') String fileMime,
    @Default(0) int fileSize,
  }) = _AppFile;

  factory AppFile.fromJson(Map<String, dynamic> json) => _$AppFileFromJson(json);
}

enum UploadType {
  @JsonValue('post_thumbnail')
  postThumbnail,
  @JsonValue('post_video')
  postVideo,
  @JsonValue('post_image')
  postImage,
  @JsonValue('sound_audio')
  soundAudio,
  @JsonValue('sound_image')
  soundImage,
  @JsonValue('user_image')
  userImage,
  @JsonValue('gift_image')
  giftImage,
  @JsonValue('news_image')
  newsImage,
  @JsonValue('app_logo')
  appLogo,
  @JsonValue('splash_image')
  splashImage,
  @JsonValue('product_thumbnail')
  productThumbnail,
  @JsonValue('flash_sale_image')
  flashSaleImage,
  @JsonValue('review_image')
  reviewImage;

  String get name {
    return switch (this) {
      UploadType.postThumbnail => 'post_thumbnail',
      UploadType.postVideo => 'post_video',
      UploadType.postImage => 'post_image',
      UploadType.soundAudio => 'sound_audio',
      UploadType.soundImage => 'sound_image',
      UploadType.userImage => 'user_image',
      UploadType.giftImage => 'gift_image',
      UploadType.newsImage => 'news_image',
      UploadType.appLogo => 'app_logo',
      UploadType.splashImage => 'splash_image',
      UploadType.productThumbnail => 'product_thumbnail',
      UploadType.flashSaleImage => 'flash_sale_image',
      UploadType.reviewImage => 'review_image',
    };
  }
}
