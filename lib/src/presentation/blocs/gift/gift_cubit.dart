part of '../blocs.dart';

@lazySingleton
class GiftCubit extends Cubit<GiftState> with CubitActionMixin<GiftState> {
  final IGiftRepository _giftRepository;

  GiftCubit(this._giftRepository) : super(GiftState.initial());

  void setCurrentGift(Gift gift) => emit(state.copyWith(currentGift: gift));
  void setSort(bool sort) => emit(state.copyWith(sort: sort));

  Future<void> fetchGiftList({bool enableSort = false}) async {
    if (enableSort) {
      setSort(!state.sort);
    }
    executeAction(
      action: () => _giftRepository.fetchGiftList(state.sort),
      onSuccess: (response) => emit(state.copyWith(giftList: response.data!)),
    );
  }

  Future<void> createGift(Map<String, dynamic> body) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _giftRepository.createGift(body),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        fetchGiftList(); // Refresh gift list after creating new gift
      },
    );
  }

  Future<void> giveGift({
    required Gift gift,
    GiftType giftType = GiftType.post,
    int typeId = 0,
    void Function(Gift)? onSendGift,
  }) async {
    if (typeId == 0) return;
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _giftRepository.giveGift({
        'gift_id': gift.id,
        'type': giftType.name,
        'type_id': typeId,
      }),
      onSuccess: (response) {
        fetchGiftList(); // Refresh gift list after giving gift
        if (onSendGift == null) DMessage.showMessage(message: response.message, type: MessageType.success);
        onSendGift?.call(response.data!.gift);
      },
    );
  }
}
