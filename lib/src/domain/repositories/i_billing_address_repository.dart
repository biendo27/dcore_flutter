part of 'repositories.dart';

abstract interface class IBillingAddressRepository {
  Future<BaseResponseList<UserBillingAddress>> fetchBillingAddress();
  Future<BaseResponse> createBillingAddress(Map<String, dynamic> body);
  Future<BaseResponse> updateBillingAddress(Map<String, dynamic> body);
  Future<BaseResponseList<Nation>> fetchNationList();
  Future<BaseResponseList<City>> fetchCityList(int nationId);
  Future<BaseResponseList<District>> fetchDistrictList(int cityId);
  Future<BaseResponseList<Ward>> fetchWardList(int districtId);
}
