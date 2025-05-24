part of 'repositories.dart';

abstract interface class IFollowRepository {
  Future<BaseResponse<BasePageBreak<AppUser>>> fetchUserList(int userId, UserType type, String search, int page);
  Future<BaseResponse<AppUser>> updateUserFollow(int userId);
  Future<BaseResponse> removeSuggestion(int userId);
}
