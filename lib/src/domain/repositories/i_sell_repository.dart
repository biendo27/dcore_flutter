part of 'repositories.dart';

abstract interface class ISellRepository {
  Future<BaseResponse<StoreHome>> fetchSellHome();
  Future<BaseResponse<StoreFlashSale>> fetchFlashSell();
}

