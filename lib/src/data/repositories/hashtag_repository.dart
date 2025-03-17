part of 'repositories.dart';

@LazySingleton(as: IHashtagRepository)
class HashtagRepository with DataStateConvertible implements IHashtagRepository {
  final HashtagApi _hashtagApi;
  HashtagRepository(this._hashtagApi);

  @override
  Future<BaseResponse<BasePageBreak<HashTag>>> fetchHashtagList(int page, String search) {
    return request(apiCall: () => _hashtagApi.fetchHashtagList(page, search));
  }
} 