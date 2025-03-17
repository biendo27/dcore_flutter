part of 'repositories.dart';

@LazySingleton(as: ISellRepository)
class SellRepository with DataStateConvertible implements ISellRepository {
  final SellApi _sellApi;
  SellRepository(this._sellApi);

  @override
  Future<BaseResponse<StoreHome>> fetchSellHome() {
    return request(apiCall: _sellApi.fetchSellHome);
  }

  @override
  Future<BaseResponse<StoreFlashSale>> fetchFlashSell() {
    return request(apiCall: _sellApi.fetchFlashSell);
  }
}
