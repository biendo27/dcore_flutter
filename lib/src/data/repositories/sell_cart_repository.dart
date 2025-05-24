part of 'repositories.dart';

@LazySingleton(as: ISellCartRepository)
class SellCartRepository with DataStateConvertible implements ISellCartRepository {
  final SellCartApi _sellCartApi;
  SellCartRepository(this._sellCartApi);

  @override
  Future<BaseResponse<UserCart>> fetchCart() {
    return request(apiCall: _sellCartApi.fetchCart);
  }

  @override
  Future<BaseResponse<Product>> fetchProductByVariant(Map<String, dynamic> queries) {
    return request(apiCall: () => _sellCartApi.fetchProductByVariant(queries));
  }

  @override
  Future<BaseResponse> addCart(Map<String, dynamic> body) {
    return request(apiCall: () => _sellCartApi.addCart(body));
  }

  @override
  Future<BaseResponse> updateCart(Map<String, dynamic> body) {
    return request(apiCall: () => _sellCartApi.updateCart(body));
  }

  @override
  Future<BaseResponse> deleteCart(int cartId) {
    return request(apiCall: () => _sellCartApi.deleteCart(cartId));
  }
}
