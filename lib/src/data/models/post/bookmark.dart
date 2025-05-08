part of '../models.dart';

// @freezed
// abstract class Bookmark with _$Bookmark {
//   const factory Bookmark({
//     @Default(0) int id,
//   }) = _Bookmark;

//   factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
// }
enum BookmarkType {
  @JsonValue('post')
  post,
  @JsonValue('sound')
  sound,
  @JsonValue('filter')
  filter,
  @JsonValue('product')
  product;
}
