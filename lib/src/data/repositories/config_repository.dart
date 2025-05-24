part of 'repositories.dart';

@LazySingleton(as: IConfigRepository)
class ConfigRepository with DataStateConvertible implements IConfigRepository {
  final ConfigApi _configApi;
  ConfigRepository(this._configApi);

  @override
  Future<BaseResponseList<AppIntro>> fetchSplash() {
    return requestList(apiCall: _configApi.fetchSplash);
  }

  @override
  Future<BaseResponse<Contact>> fetchConfig() {
    return request(apiCall: _configApi.fetchConfig);
  }

  @override
  Future<BaseResponse<String>> fetchAppName() {
    return request(apiCall: _configApi.fetchAppName);
  }

  @override
  Future<BaseResponse<String>> fetchTermsOfUseApp() {
    return request(apiCall: _configApi.fetchTermsOfUseApp);
  }

  @override
  Future<BaseResponse<String>> fetchTermOfSalePolicy() {
    return request(apiCall: _configApi.fetchTermOfSalePolicy);
  }

  @override
  Future<BaseResponse<String>> fetchPrivacyPolicy() {
    return request(apiCall: _configApi.fetchPrivacyPolicy);
  }
}
