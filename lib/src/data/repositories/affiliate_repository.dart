part of 'repositories.dart';

@LazySingleton(as: IAffiliateRepository)
class AffiliateRepository with DataStateConvertible implements IAffiliateRepository {
  final AffiliateApi _affiliateApi;
  AffiliateRepository(this._affiliateApi);

  @override
  Future<BaseResponse> affiliateWithdraw(int money) {
    return request(apiCall: () => _affiliateApi.affiliateWithdraw(money));
  }

  @override
  Future<BaseResponse> affiliateAddProduct(int id) {
    return request(apiCall: () => _affiliateApi.affiliateAddProduct(id));
  }

  @override
  Future<BaseResponse<CommissionRepository>> affiliateCommission(int page) {
    return request(apiCall: () => _affiliateApi.affiliateCommission(page));
  }

  @override
  Future<BaseResponse<HomeAffiliateRepository>> affiliateHome(int page) {
    return request(apiCall: () => _affiliateApi.affiliateHome(page));
  }

  @override
  Future<BaseResponse<int>> affiliateMoneyToCoin(int money) {
    return request(apiCall: () => _affiliateApi.affiliateMoneyToCoin(money));
  }

  @override
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
  }) {
    return request(apiCall: () => _affiliateApi.affiliateProductList(rating, categoryId, fromPrice, toPrice, servicePromotion, type, sort, keyword, commission, page));
  }

  @override
  Future<BaseResponse> affiliateRegister(Map<String, dynamic> body) {
    return request(apiCall: () => _affiliateApi.affiliateRegister(body));
  }

  @override
  Future<BaseResponseList<AffiliateRequest>> affiliateRequest() {
    return requestList(apiCall: _affiliateApi.affiliateRequest);
  }

  @override
  Future<BaseResponse> affiliateUpdate(Map<String, dynamic> body) {
    return request(apiCall: () => _affiliateApi.affiliateUpdate(body));
  }

  @override
  Future<BaseResponse<AffiliateInfo>> affiliateInfo() {
    return request(apiCall: _affiliateApi.affiliateInfo);
  }

  @override
  Future<BaseResponseList<Product>> affiliateProduct() {
    return requestList(apiCall: _affiliateApi.affiliateProduct);
  }
}
