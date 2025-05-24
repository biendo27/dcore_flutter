part of 'repositories.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository with DataStateConvertible implements IProfileRepository {
  final ProfileApi _profileApi;
  ProfileRepository(this._profileApi);

  @override
  Future<BaseResponse<AppUser>> fetchMyProfile() {
    return request(apiCall: _profileApi.fetchMyProfile);
  }

  @override
  Future<BaseResponse<AppUser>> fetchProfile(int userId) {
    return request(apiCall: () => _profileApi.fetchProfile(userId));
  }

  @override
  Future<BaseResponse> updateLanguage(String languageCode) {
    return request(apiCall: () => _profileApi.updateLanguage(languageCode));
  }

  @override
  Future<BaseResponse<AppUser>> updateProfile(AppUser user) {
    return request(apiCall: () => _profileApi.updateProfile(user));
  }

  @override
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserPost(int userId, int page) {
    return request(apiCall: () => _profileApi.fetchUserPost(userId, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserPostBookmarkList(int userId, int page) {
    return request(apiCall: () => _profileApi.fetchUserPostBookmarkList(userId, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserLikePost(int userId, int page) {
    return request(apiCall: () => _profileApi.fetchUserLikePost(userId, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<Sound>>> fetchUserSoundBookmarkList(int userId, int page) {
    return request(apiCall: () => _profileApi.fetchUserSoundBookmarkList(userId, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<MediaFilter>>> fetchUserFilterBookmarkList(int userId, int page) {
    return request(apiCall: () => _profileApi.fetchUserFilterBookmarkList(userId, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<Product>>> fetchUserProductBookmarkList(int userId, int page) {
    return request(apiCall: () => _profileApi.fetchUserProductBookmarkList(userId, page));
  }

  @override
  Future<BaseResponseList> fetchUserBookmark(int userId, BookmarkType type) {
    return requestList(apiCall: () => _profileApi.fetchUserBookmark(userId, type));
  }

  @override
  Future<BaseResponse> updateUserSocketId(String socketId) {
    return request(apiCall: () => _profileApi.updateUserSocketId(socketId));
  }
}
