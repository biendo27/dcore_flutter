part of 'repositories.dart';

abstract interface class ISellCartRepository {
  Future<BaseResponse<UserCart>> fetchCart();
  Future<BaseResponse<Product>> fetchProductByVariant(Map<String, dynamic> queries);
  Future<BaseResponse> addCart(Map<String, dynamic> body);
  Future<BaseResponse> updateCart(Map<String, dynamic> body);
  Future<BaseResponse> deleteCart(int cartId);
}
