part of 'repositories.dart';

@LazySingleton(as: ITermRepository)
class TermRepository with DataStateConvertible implements ITermRepository {
  final TermApi _termApi;
  TermRepository(this._termApi);

  @override
  Future<BaseResponse> fetchTerms() {
    return request(apiCall: _termApi.fetchTerms);
  }
}
