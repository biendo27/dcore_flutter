part of '../blocs.dart';

@lazySingleton
class LiveSocketCubit extends Cubit<LiveSocketState> with CubitActionMixin<LiveSocketState> {
  final BaseSocket _socketLive;
  final IProfileRepository _profileRepository;

  LiveSocketCubit(@Named(DIKey.socketLive) this._socketLive, this._profileRepository) : super(LiveSocketState.initial());

  void setRoomId(String roomId) => emit(state.copyWith(roomId: roomId));

  void initSocket() {
    _socketLive
      ..initSocket()
      ..initDefaultListener(
        onConnectSuccess: (_) => emit(state.copyWith(status: SocketLiveStatus.connected)),
        onDisconnectSuccess: (_) => emit(state.copyWith(status: SocketLiveStatus.disconnected)),
        updateUserSocketId: (socketId) => executeEmptyAction(action: () => _profileRepository.updateUserSocketId(socketId)),
      );
  }

  void initConnection() {
    if (state.status == SocketLiveStatus.connected) return;
    _socketLive.initConnection();
  }

  void closeConnection() {
    if (state.status == SocketLiveStatus.disconnected) return;
    _socketLive.closeConnection();
  }

  void joinLive() {
    listenComment();
    listenGift();
    listenUserJoin();
    listenUserLeave();
    listenHeart();
    listenNewViewer();
    listenNewPinComment();
    listenNewOrderLive();
    listenNewPinProduct();
    listenNewUserReceiveGift();
    listenNewSettingGift();
  }

  void leaveLive() => _socketLive.removeAllListener();

  void listenComment() {
    _socketLive.addListener(LiveSocketListenerEvent.newComment(state.roomId), (data) {
      BaseSocketResponse<LiveCommentSocketData> commentData = BaseSocketResponse<LiveCommentSocketData>.fromJson(
        data,
        (json) => LiveCommentSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context?.read<LiveCommentCubit>().addComment(commentData.data!.message);
      Live live = commentData.data!.live;
      if (live.id != 0) AppConfig.context?.read<LiveCubit>().setCurrentLive(live);
    });
  }

  void listenGift() {
    _socketLive.addListener(LiveSocketListenerEvent.newGift(state.roomId), (data) {
      BaseSocketResponse<LiveGiftSocketData> giftData = BaseSocketResponse<LiveGiftSocketData>.fromJson(
        data,
        (json) => LiveGiftSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context?.read<LiveGiftCubit>().addGift(giftData.data!.gift);
      Live live = giftData.data!.live;
      if (live.id != 0) AppConfig.context?.read<LiveCubit>().setCurrentLive(live);
    });
  }

  void listenUserJoin() {
    _socketLive.addListener(LiveSocketListenerEvent.userJoin(state.roomId), (data) {
      BaseSocketResponse<LiveCommentSocketData> userData = BaseSocketResponse<LiveCommentSocketData>.fromJson(
        data,
        (json) => LiveCommentSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context?.read<LiveCommentCubit>().addComment(userData.data!.message);
    });
  }

  void listenUserLeave() {
    _socketLive.addListener(LiveSocketListenerEvent.userLeave(state.roomId), (data) {
      BaseSocketResponse<LiveCommentSocketData> userData = BaseSocketResponse<LiveCommentSocketData>.fromJson(
        data,
        (json) => LiveCommentSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context?.read<LiveCommentCubit>().addComment(userData.data!.message);
    });
  }

  void listenHeart() {
    _socketLive.addListener(LiveSocketListenerEvent.newHeart(state.roomId), (data) {
      BaseSocketResponse<LiveHeartSocketData> heartData = BaseSocketResponse<LiveHeartSocketData>.fromJson(
        data,
        (json) => LiveHeartSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context
        ?..read<LiveHeartCubit>().addHeart()
        ..read<LiveCubit>().setLiveHeartCount(heartData.data!.count);
      Live live = heartData.data!.live;
      if (live.id != 0) AppConfig.context?.read<LiveCubit>().setCurrentLive(live);
    });
  }

  void listenNewViewer() {
    _socketLive.addListener(LiveSocketListenerEvent.newViewer(state.roomId), (data) {
      BaseSocketResponse<LiveViewerSocketData> viewerData = BaseSocketResponse<LiveViewerSocketData>.fromJson(
        data,
        (json) => LiveViewerSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context?.read<LiveCubit>().setLiveViewCount(viewerData.data!.users.length);
      AppConfig.context?.read<LiveViewerCubit>().updateViewers(viewerData.data!.users);
      // AppConfig.context?.read<LiveViewerCubit>().addViewer(viewerData.data.viewer);
    });
  }

  void listenNewPinComment() {
    _socketLive.addListener(LiveSocketListenerEvent.newPinComment(state.roomId), (data) {
      BaseSocketResponse<LiveCommentSocketData> commentData = BaseSocketResponse<LiveCommentSocketData>.fromJson(
        data,
        (json) => LiveCommentSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context?.read<LiveCommentCubit>().setPinComment(commentData.data!.message);
    });
  }

  void listenNewOrderLive() {
    _socketLive.addListener(LiveSocketListenerEvent.newOrderLive(state.roomId), (data) {
      BaseSocketResponse<LiveOrderSocketData> orderData = BaseSocketResponse<LiveOrderSocketData>.fromJson(
        data,
        (json) => LiveOrderSocketData.fromJson(json as Map<String, dynamic>),
      );
      Live live = orderData.data!.live;
      if (live.id != 0) AppConfig.context?.read<LiveCubit>().setCurrentLive(live);
    });
  }

  void listenNewPinProduct() {
    _socketLive.addListener(LiveSocketListenerEvent.newPinProduct(state.roomId), (data) {
      BaseSocketResponse<LiveSocketData> liveData = BaseSocketResponse<LiveSocketData>.fromJson(
        data,
        (json) => LiveSocketData.fromJson(json as Map<String, dynamic>),
      );
      AppConfig.context?.read<LiveCubit>().setCurrentLive(liveData.data!.live);
    });
  }

  void listenNewUserReceiveGift() {
    _socketLive.addListener(LiveSocketListenerEvent.newUserReceiveGift(state.roomId), (data) {
      BaseSocketResponse<LiveSocketUserReceiveGift> receiptData = BaseSocketResponse<LiveSocketUserReceiveGift>.fromJson(data, (json) => LiveSocketUserReceiveGift.fromJson(json as Map<String, dynamic>));
      AppConfig.context?.read<LiveMissionCubit>().setGiftRecipient(receiptData.data!.user);
      AppConfig.context?.read<LiveCubit>().setCurrentLive(receiptData.data!.live);
    });
  }

  void listenNewSettingGift() {
    _socketLive.addListener(LiveSocketListenerEvent.newSettingGift(state.roomId), (data) {
      BaseSocketResponse<LiveSocketData> liveData = BaseSocketResponse<LiveSocketData>.fromJson(data, (json) => LiveSocketData.fromJson(json as Map<String, dynamic>));
      AppConfig.context?.read<LiveCubit>().setCurrentLive(liveData.data!.live);
    });
  }
}
