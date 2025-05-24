part of 'repositories.dart';

abstract interface class ISellProductRepository {
  Future<BaseResponseList<Product>> fetchProduct(Map<String, dynamic> queries);
  Future<BaseResponse<Filter>> fetchProductFilter();
  Future<BaseResponse<ProductDetail>> fetchProductDetail(int productId);
  Future<BaseResponse<BasePageBreak<ProductReview>>> fetchProductReview(int productId, int page);
  Future<BaseResponse> postProduct(Map<String, dynamic> body);
  Future<BaseResponseList<Product>> fetchOtherProduct(int productId);
  Future<BaseResponseList<Voucher>> fetchProductVoucher(int productId);
  Future<BaseResponse<ProductService>> fetchProductService();
  Future<BaseResponse<String>> fetchProductServiceDetail(ProductServiceType type);
  Future<BaseResponse> bookmarkProduct(int productId);
  Future<BaseResponseList<Product>> fetchProductSuggest();
  Future<BaseResponse<String>> fetchProductCancelOrderTutorialTerm();
}
