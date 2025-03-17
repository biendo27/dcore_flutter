part of 'repositories.dart';

@LazySingleton(as: ISearchRepository)
class SearchRepository with DataStateConvertible implements ISearchRepository {
  final SearchApi _searchApi;
  SearchRepository(this._searchApi);

  @override
  Future<BaseResponse<SearchHistory>> fetchSearchHistory() {
    return request(apiCall: _searchApi.fetchSearchHistory);
  }

  @override
  Future<BaseResponseList<SearchKeyword>> fetchListKeyword(String keyword) {
    return requestList(apiCall: () => _searchApi.fetchListKeyword(keyword));
  }

  @override
  Future<BaseResponse> saveKeywordHistory(String keyword) {
    return request(apiCall: () => _searchApi.saveKeywordHistory(keyword));
  }

  @override
  Future<BaseResponse> removeKeywordHistory(Map<String, dynamic> body) {
    return request(apiCall: () => _searchApi.removeKeywordHistory(body));
  }
} 