part of 'repositories.dart';

abstract interface class IConfigRepository {
  Future<BaseResponseList<AppIntro>> fetchSplash();
  Future<BaseResponse<Contact>> fetchConfig();
  Future<BaseResponse<String>> fetchAppName();
  Future<BaseResponse<String>> fetchTermsOfUseApp();
  Future<BaseResponse<String>> fetchTermOfSalePolicy();
  Future<BaseResponse<String>> fetchPrivacyPolicy();
}
