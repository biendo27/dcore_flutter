part of 'repositories.dart';

@LazySingleton(as: IActivityRepository)
class ActivityRepository with DataStateConvertible implements IActivityRepository {
  final ActivityApi _activityApi;
  ActivityRepository(this._activityApi);

  @override
  Future<BaseResponseList> fetchOrder() {
    return requestList(apiCall: _activityApi.fetchOrder);
  }

  @override
  Future<BaseResponseList> fetchSearchHistory() {
    return requestList(apiCall: _activityApi.fetchSearchHistory);
  }
}
