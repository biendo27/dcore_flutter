part of 'repositories.dart';

abstract interface class ISellVoucherRepository {
  Future<BaseResponseList<Voucher>> fetchVoucher(Map<String, dynamic> queries);
  Future<BaseResponse<Voucher>> fetchVoucherDetail(int voucherId);
  Future<BaseResponse> addVoucher(int voucherId);
  Future<BaseResponse<Voucher>> saveVoucher(int voucherId);
  Future<BaseResponse<UsageTerm>> fetchVoucherUsageTerms(int voucherId);
} 