part of 'repositories.dart';

@LazySingleton(as: ILiveCensorRepository)
class LiveCensorRepository with DataStateConvertible implements ILiveCensorRepository {
  final LiveCensorApi _liveCensorApi;
  LiveCensorRepository(this._liveCensorApi);

  @override
  Future<BaseResponseList<LiveCensorForm>> getLiveCensorForm(int liveId) {
    return requestList(apiCall: () => _liveCensorApi.getLiveCensorForm(liveId));
  }

  @override
  Future<BaseResponse<UserLiveCensor>> saveLiveCensor(Map<String, dynamic> body) {
    return request(apiCall: () => _liveCensorApi.saveLiveCensor(body));
  }

  @override
  Future<BaseResponse<UserLiveCensor>> getLiveCensorResult(int liveId) {
    return request(apiCall: () => _liveCensorApi.getLiveCensorResult(liveId));
  }
}