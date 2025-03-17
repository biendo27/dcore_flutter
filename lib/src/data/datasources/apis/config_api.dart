part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class ConfigApi {
  @factoryMethod
  factory ConfigApi(@Named(DIKey.appDio) Dio dio) = _ConfigApi;

  @GET(AppEndpoint.splash)
  Future<BaseResponseList<AppIntro>> fetchSplash();

  @GET(AppEndpoint.config)
  Future<BaseResponse<Contact>> fetchConfig();

  @GET(AppEndpoint.appName)
  Future<BaseResponse<String>> fetchAppName();

  @GET(AppEndpoint.termsOfUseApp)
  Future<BaseResponse<String>> fetchTermsOfUseApp();

  @GET(AppEndpoint.termsOfSalePolicy)
  Future<BaseResponse<String>> fetchTermOfSalePolicy();

  @GET(AppEndpoint.privacyPolicy)
  Future<BaseResponse<String>> fetchPrivacyPolicy();
}
