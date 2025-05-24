part of 'repositories.dart';

@LazySingleton(as: IBillingAddressRepository)
class BillingAddressRepository with DataStateConvertible implements IBillingAddressRepository {
  final BillingAddressApi _billingAddressApi;
  BillingAddressRepository(this._billingAddressApi);

  @override
  Future<BaseResponseList<UserBillingAddress>> fetchBillingAddress() {
    return requestList(apiCall: _billingAddressApi.fetchBillingAddress);
  }

  @override
  Future<BaseResponse> createBillingAddress(Map<String, dynamic> body) {
    return request(apiCall: () => _billingAddressApi.createBillingAddress(body));
  }

  @override
  Future<BaseResponse> updateBillingAddress(Map<String, dynamic> body) {
    return request(apiCall: () => _billingAddressApi.updateBillingAddress(body));
  }

  @override
  Future<BaseResponseList<Nation>> fetchNationList() {
    return requestList(apiCall: _billingAddressApi.fetchNationList);
  }

  @override
  Future<BaseResponseList<City>> fetchCityList(int nationId) {
    return requestList(apiCall: () => _billingAddressApi.fetchCityList(nationId));
  }

  @override
  Future<BaseResponseList<District>> fetchDistrictList(int cityId) {
    return requestList(apiCall: () => _billingAddressApi.fetchDistrictList(cityId));
  }

  @override
  Future<BaseResponseList<Ward>> fetchWardList(int districtId) {
    return requestList(apiCall: () => _billingAddressApi.fetchWardList(districtId));
  }
}
