part of '../blocs.dart';

@lazySingleton
class GiftShopCubit extends Cubit<GiftShopState> with CubitActionMixin<GiftShopState> {
  final IGiftShopRepository _giftShopRepository;
  GiftShopCubit(this._giftShopRepository) : super(GiftShopState.initial());

  Future<void> fetchGiftShopList() async {
    executeListAction<GiftMain>(
      action: () => _giftShopRepository.fetchGiftShopList(),
      onSuccess: (response) {
        emit(state.copyWith(data: response.data));
      },
    );
  }
}
