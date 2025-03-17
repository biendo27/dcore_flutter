part of 'repositories.dart';

abstract interface class IRankRepository {
  Future<BaseResponse<RankConfig>> fetchRank();
  Future<BaseResponseList<Rank>> fetchRankHistory();
  Future<BaseResponse<Rank>> fetchRankDetail(int rankId);
}
