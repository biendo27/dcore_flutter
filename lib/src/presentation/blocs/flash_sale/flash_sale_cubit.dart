part of '../blocs.dart';

@lazySingleton
class FlashSaleCubit extends Cubit<FlashSaleState> with CubitActionMixin<FlashSaleState> {
  final ISellRepository _sellRepository;
  FlashSaleCubit(this._sellRepository) : super(FlashSaleState.initial());

  void fetchFlashSale() async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellRepository.fetchFlashSell(),
      onSuccess: (response) => emit(state.copyWith(currentFlashSale: response.data!)),
    );
  }
}
