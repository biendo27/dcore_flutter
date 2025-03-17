part of 'repositories.dart';

@LazySingleton(as: INewsRepository)
class NewsRepository with DataStateConvertible implements INewsRepository {
  final NewsApi _newsApi;
  NewsRepository(this._newsApi);

  @override
  Future<BaseResponse<AppNews>> getNewsDetail(int newsId) {
    return request(apiCall: () => _newsApi.getNewsDetail(newsId));
  }
}
