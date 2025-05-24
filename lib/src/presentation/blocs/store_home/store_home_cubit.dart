part of '../blocs.dart';

@lazySingleton
class StoreHomeCubit extends Cubit<StoreHomeState> with CubitActionMixin<StoreHomeState> {
  final ISellRepository _sellRepository;
  StoreHomeCubit(this._sellRepository) : super(StoreHomeState.initial());

  void setStoreHome(StoreHome storeHome) => emit(state.copyWith(storeHome: storeHome));

  Future<void> fetchStoreHome({void Function()? onSuccess}) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: _sellRepository.fetchSellHome,
      onSuccess: (response) {
        setStoreHome(response.data!);
        onSuccess?.call();
      },
    );
  }
}
