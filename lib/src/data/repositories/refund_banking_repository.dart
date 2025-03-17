part of 'repositories.dart';

@LazySingleton(as: IRefundBankingRepository)
class RefundBankingRepository with DataStateConvertible implements IRefundBankingRepository {
  final RefundBankingApi _refundBankingApi;
  RefundBankingRepository(this._refundBankingApi);

  @override
  Future<BaseResponse<RefundBanking>> fetchRefundBanking() {
    return request(apiCall: _refundBankingApi.fetchRefundBanking);
  }

  @override
  Future<BaseResponse> updateRefundBanking(Map<String, dynamic> body) {
    return request(apiCall: () => _refundBankingApi.updateRefundBanking(body));
  }

  @override
  Future<BaseResponseList<UserBank>> fetchRefundBankingListBankData() {
    return requestList(apiCall: _refundBankingApi.fetchRefundBankingListBankData);
  }
}
