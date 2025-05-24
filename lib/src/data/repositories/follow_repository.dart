part of 'repositories.dart';

@LazySingleton(as: IFollowRepository)
class FollowRepository with DataStateConvertible implements IFollowRepository {
  final FollowApi _followApi;
  FollowRepository(this._followApi);

  @override
  Future<BaseResponse<BasePageBreak<AppUser>>> fetchUserList(int userId, UserType type, String search, int page) {
    return request(apiCall: () => _followApi.fetchUserList(userId, type, search, page));
  }

  @override
  Future<BaseResponse<AppUser>> updateUserFollow(int userId) {
    return request(apiCall: () => _followApi.updateUserFollow(userId));
  }

  @override
  Future<BaseResponse> removeSuggestion(int userId) {
    return request(apiCall: () => _followApi.removeSuggestion(userId));
  }
}
