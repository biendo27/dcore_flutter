part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class TermApi {
  @factoryMethod
  factory TermApi(@Named(DIKey.appDio) Dio dio) = _TermApi;

  @GET(AppEndpoint.terms)
  Future<BaseResponse> fetchTerms();
}
