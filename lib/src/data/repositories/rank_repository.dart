part of 'repositories.dart';

@LazySingleton(as: IRankRepository)
class RankRepository with DataStateConvertible implements IRankRepository {
  final RankApi _rankApi;
  RankRepository(this._rankApi);

  @override
  Future<BaseResponse<RankConfig>> fetchRank() {
    return request(apiCall: _rankApi.fetchRank);
  }

  @override
  Future<BaseResponseList<Rank>> fetchRankHistory() {
    return requestList(apiCall: _rankApi.fetchRankHistory);
  }

  @override
  Future<BaseResponse<Rank>> fetchRankDetail(int rankId) {
    return request(apiCall: () => _rankApi.fetchRankDetail(rankId));
  }
}