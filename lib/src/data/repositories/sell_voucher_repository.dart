part of 'repositories.dart';

@LazySingleton(as: ISellVoucherRepository)
class SellVoucherRepository with DataStateConvertible implements ISellVoucherRepository {
  final SellVoucherApi _sellVoucherApi;
  SellVoucherRepository(this._sellVoucherApi);

  @override
  Future<BaseResponseList<Voucher>> fetchVoucher(Map<String, dynamic> queries) {
    return requestList(apiCall: () => _sellVoucherApi.fetchVoucher(queries));
  }

  @override
  Future<BaseResponse<Voucher>> fetchVoucherDetail(int voucherId) {
    return request(apiCall: () => _sellVoucherApi.fetchVoucherDetail(voucherId));
  }

  @override
  Future<BaseResponse> addVoucher(int voucherId) {
    return request(apiCall: () => _sellVoucherApi.addVoucher(voucherId));
  }

  @override
  Future<BaseResponse<Voucher>> saveVoucher(int voucherId) {
    return request(apiCall: () => _sellVoucherApi.saveVoucher(voucherId));
  }

  @override
  Future<BaseResponse<UsageTerm>> fetchVoucherUsageTerms(int voucherId) {
    return request(apiCall: () => _sellVoucherApi.fetchVoucherUsageTerms(voucherId));
  }
} 