part of 'repositories.dart';

abstract interface class IProfileRepository {
  Future<BaseResponse<AppUser>> fetchProfile(int userId);
  Future<BaseResponse<AppUser>> fetchMyProfile();
  Future<BaseResponse<AppUser>> updateProfile(AppUser user);
  Future<BaseResponse> updateLanguage(String languageCode);
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserPost(int userId, int page);
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserPostBookmarkList(int userId, int page);
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserLikePost(int userId, int page);
  Future<BaseResponse<BasePageBreak<Sound>>> fetchUserSoundBookmarkList(int userId, int page);
  Future<BaseResponse<BasePageBreak<MediaFilter>>> fetchUserFilterBookmarkList(int userId, int page);
  Future<BaseResponse<BasePageBreak<Product>>> fetchUserProductBookmarkList(int userId, int page);
  Future<BaseResponseList> fetchUserBookmark(int userId, BookmarkType type);
  Future<BaseResponse> updateUserSocketId(String socketId);
}
