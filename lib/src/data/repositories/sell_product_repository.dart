part of 'repositories.dart';

@LazySingleton(as: ISellProductRepository)
class SellProductRepository with DataStateConvertible implements ISellProductRepository {
  final SellProductApi _sellProductApi;
  SellProductRepository(this._sellProductApi);

  @override
  Future<BaseResponseList<Product>> fetchProduct(Map<String, dynamic> queries) {
    return requestList(apiCall: () => _sellProductApi.fetchProduct(queries));
  }

  @override
  Future<BaseResponse<Filter>> fetchProductFilter() {
    return request(apiCall: _sellProductApi.fetchProductFilter);
  }

  @override
  Future<BaseResponse<ProductDetail>> fetchProductDetail(int productId) {
    return request(apiCall: () => _sellProductApi.fetchProductDetail(productId));
  }

  @override
  Future<BaseResponse<BasePageBreak<ProductReview>>> fetchProductReview(int productId, int page) {
    return request(apiCall: () => _sellProductApi.fetchProductReview(productId, page));
  }

  @override
  Future<BaseResponse> postProduct(Map<String, dynamic> body) {
    return request(apiCall: () => _sellProductApi.postProduct(body));
  }

  @override
  Future<BaseResponseList<Product>> fetchOtherProduct(int productId) {
    return requestList(apiCall: () => _sellProductApi.fetchOtherProduct(productId));
  }

  @override
  Future<BaseResponseList<Voucher>> fetchProductVoucher(int productId) {
    return requestList(apiCall: () => _sellProductApi.fetchProductVoucher(productId));
  }

  @override
  Future<BaseResponse<ProductService>> fetchProductService() {
    return request(apiCall: () => _sellProductApi.fetchProductService());
  }

  @override
  Future<BaseResponse<String>> fetchProductServiceDetail(ProductServiceType type) {
    return request(apiCall: () => _sellProductApi.fetchProductServiceDetail(type));
  }

  @override
  Future<BaseResponse> bookmarkProduct(int productId) {
    return request(apiCall: () => _sellProductApi.bookmarkProduct(productId));
  }

  @override
  Future<BaseResponseList<Product>> fetchProductSuggest() {
    return requestList(apiCall: _sellProductApi.fetchProductSuggest);
  }

  @override
  Future<BaseResponse<String>> fetchProductCancelOrderTutorialTerm() {
    return request(apiCall: _sellProductApi.fetchProductCancelOrderTutorialTerm);
  }
}
