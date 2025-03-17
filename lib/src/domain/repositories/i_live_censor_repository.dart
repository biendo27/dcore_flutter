part of 'repositories.dart';

abstract interface class ILiveCensorRepository {
  Future<BaseResponseList<LiveCensorForm>> getLiveCensorForm(int liveId);
  Future<BaseResponse<UserLiveCensor>> saveLiveCensor(Map<String, dynamic> body);
  Future<BaseResponse<UserLiveCensor>> getLiveCensorResult(int liveId);
}