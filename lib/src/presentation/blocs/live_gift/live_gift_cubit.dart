part of '../blocs.dart';

@lazySingleton
class LiveGiftCubit extends Cubit<LiveGiftState> {
  LiveGiftCubit() : super(LiveGiftState.initial());

  addGift(Gift gift) {
    List<Gift> gifts = [...state.gifts];
    gifts.add(gift);
    emit(state.copyWith(gifts: gifts));
  }

  removeGift(Gift gift) {
    List<Gift> gifts = [...state.gifts];
    gifts.remove(gift);
    emit(state.copyWith(gifts: gifts));
  }
}
