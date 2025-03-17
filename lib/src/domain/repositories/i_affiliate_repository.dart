part of 'repositories.dart';

abstract interface class IAffiliateRepository {
  Future<BaseResponseList<AffiliateRequest>> affiliateRequest();
  Future<BaseResponse> affiliateAddProduct(int id);
  Future<BaseResponse<CommissionRepository>> affiliateCommission(int page);
  Future<BaseResponse<HomeAffiliateRepository>> affiliateHome(int page);
  Future<BaseResponse<int>> affiliateMoneyToCoin(int money);
  Future<BaseResponse<ProductList>> affiliateProductList({
    int? rating,
    int? categoryId,
    int? fromPrice,
    int? toPrice,
    int? servicePromotion,
    int? type,
    String? sort,
    String? keyword,
    String? commission,
    int? page,
  });
  Future<BaseResponse> affiliateRegister(Map<String, dynamic> body);
  Future<BaseResponse> affiliateUpdate(Map<String, dynamic> body);
  Future<BaseResponse> affiliateWithdraw(int money);
  Future<BaseResponse<AffiliateInfo>> affiliateInfo();
  Future<BaseResponseList<Product>> affiliateProduct();
}
