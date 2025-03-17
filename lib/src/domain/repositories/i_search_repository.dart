part of 'repositories.dart';

abstract interface class ISearchRepository {
  Future<BaseResponse<SearchHistory>> fetchSearchHistory();
  Future<BaseResponseList<SearchKeyword>> fetchListKeyword(String keyword);
  Future<BaseResponse> saveKeywordHistory(String keyword);
  Future<BaseResponse> removeKeywordHistory(Map<String, dynamic> body);
} 