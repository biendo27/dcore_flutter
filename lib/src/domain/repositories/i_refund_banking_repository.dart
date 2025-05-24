part of 'repositories.dart';

abstract interface class IRefundBankingRepository {
  Future<BaseResponse<RefundBanking>> fetchRefundBanking();
  Future<BaseResponse> updateRefundBanking(Map<String, dynamic> body);
  Future<BaseResponseList<UserBank>> fetchRefundBankingListBankData();
}
