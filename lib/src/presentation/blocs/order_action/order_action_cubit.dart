part of '../blocs.dart';

@lazySingleton
class OrderActionCubit extends Cubit<OrderActionState> with CubitActionMixin<OrderActionState> {
  final ISellOrderRepository _sellOrderRepository;
  final IUploadRepository _uploadRepository;

  OrderActionCubit(this._sellOrderRepository, this._uploadRepository) : super(OrderActionState.initial());

  void setCurrentOrder(UserOrder order) => emit(state.copyWith(currentOrder: order));

  void setActionImages(List<String> images) => emit(state.copyWith(actionImages: images));

  void addActionImages(List<String> images) => emit(state.copyWith(actionImages: [...state.actionImages, ...images]));

  void setCurrentCancelCategory(OrderCancelCategory category) => emit(state.copyWith(currentCancelCategory: category));

  void setCurrentReturnCategory(OrderReturnCategory category) => emit(state.copyWith(currentReturnCategory: category));

  void removeActionImage(String image) {
    List<String> images = [...state.actionImages];
    images.remove(image);
    emit(state.copyWith(actionImages: images));
  }

  void setSelectedReason(String reason) {
    emit(state.copyWith(selectedReason: reason));
  }

  Future<List<String>> _uploadOrderImages() async {
    if (state.actionImages.isEmpty) return [];
    List<File> files = state.actionImages.map((e) => File(e)).toList();
    final BaseResponseList<AppFile> response = await _uploadRepository.uploadFile(
      UploadType.reviewImage,
      files,
    );
    if (response.data.isNotEmpty) {
      return response.data.map((e) => e.url).toList();
    }
    return [];
  }

  void setReviewOrderData({List<int> orderId = const [], int rating = 0, String note = ''}) async {
    emit(state.copyWith(isLoading: true));
    if (orderId.isEmpty) return;

    List<String> imageUrls = await _uploadOrderImages();
    Map<String, dynamic> body = {
      'rating': rating,
      'note': note,
      'images': imageUrls,
    };

    for (int id in orderId) {
      body['order_product_id'] = id;
      sendReviewOrder(body: body);
    }
    emit(state.copyWith(isLoading: false));
    DNavigator.back();
  }

  void sendReviewOrder({
    Map<String, dynamic> body = const {},
  }) async {
    executeEmptyAction(
      action: () => _sellOrderRepository.review(body),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) {
        emit(state.copyWith(actionImages: []));
        DMessage.showMessage(message: response.message, type: MessageType.success);
        AppConfig.context?.read<OrderListCubit>().fetchOrderDetail();
        AppConfig.context!.read<OrderReviewCubit>()
          ..fetchUserReview(isInit: true)
          ..fetchProductPendingReview(isInit: true);
      },
    );
  }

  void getOrderCancelInfo() async {
    if (state.currentOrder.id == 0) return;
    executeAction(
      action: () => _sellOrderRepository.cancelInfo(state.currentOrder.id),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) => emit(state.copyWith(cancelInfo: response.data!)),
    );
  }

  void getOrderCancelCategories() async {
    executeListAction(
      action: _sellOrderRepository.cancelCategories,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) => emit(state.copyWith(cancelCategories: response.data)),
    );
  }

  void sendOrderCancel(String reason) async {
    if (state.currentOrder.id == 0) return;

    Map<String, dynamic> body = {
      'order_id': state.currentOrder.id,
      'cancel_order_category_id': state.currentCancelCategory.id,
      'reason': reason,
    };

    executeEmptyAction(
      action: () => _sellOrderRepository.cancelSave(body),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        AppConfig.context?.read<OrderListCubit>().fetchOrderDetail();
        DNavigator.back();
        DNavigator.back();
      },
    );
  }

  void getOrderReturnInfo() async {
    if (state.currentOrder.id == 0) return;
    executeAction(
      action: () => _sellOrderRepository.returnInfo(state.currentOrder.id),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) => emit(state.copyWith(returnInfo: response.data!)),
    );
  }

  void getOrderReturnCategories() async {
    executeListAction(
      action: _sellOrderRepository.returnCategories,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) => emit(state.copyWith(returnCategories: response.data)),
    );
  }

  void sendOrderReturn(String reason) async {
    if (state.currentOrder.id == 0) return;

    emit(state.copyWith(isLoading: true));

    List<String> imageUrls = await _uploadOrderImages();

    Map<String, dynamic> body = {
      'order_id': state.currentOrder.id,
      'return_order_category_id': state.currentReturnCategory.id,
      'reason': reason,
      'images': imageUrls,
    };

    executeEmptyAction(
      action: () => _sellOrderRepository.returnCreate(body),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        AppConfig.context?.read<OrderListCubit>().fetchOrderDetail();
        emit(state.copyWith(isLoading: false));
        DNavigator.back();
      },
    );
  }

  void receiveConfirm() async {
    if (state.currentOrder.id == 0) return;
    executeEmptyAction(
      action: () => _sellOrderRepository.receiveConfirm(state.currentOrder.id),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        AppConfig.context?.read<OrderListCubit>().fetchOrderDetail();
      },
    );
  }
}
