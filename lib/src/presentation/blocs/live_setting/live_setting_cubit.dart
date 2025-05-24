part of '../blocs.dart';

@lazySingleton
class LiveSettingCubit extends Cubit<LiveSettingState> with CubitActionMixin<LiveSettingState> {
  final LiveService liveService;
  final ILiveRepository _liveRepository;
  final Stopwatch stopwatch = Stopwatch();
  LiveSettingCubit(this.liveService, this._liveRepository) : super(LiveSettingState.initial());

  void resetState() => emit(LiveSettingState.initial());

  void initLive(AppUser user, Live live) {
    LiveRole role = user.isHostCurrentLive(live.user.id) ? LiveRole.host : LiveRole.audience;
    setLiveRole(role);

    liveService
      ..setUId(role != LiveRole.host ? user.id : 0)
      // ..setUId(user.id)
      ..setChannelId(live.roomId);

    // liveService.setChannelId(AgoraKey.tmpChannelId);
    setupRtcLiveEventHandler();
    liveService.setupVideoSDKEngine();
    stopwatch.start();
  }

  void setLiveRole(LiveRole role) {
    emit(state.copyWith(liveRole: role));
    liveService.setLiveRole(role);
  }

  void setLiveStatus(LiveSettingStatus status) => emit(state.copyWith(liveStatus: status));
  void setAudienceId(int audienceId) => emit(state.copyWith(audienceId: audienceId));
  void setIsLoading(bool isLoading) => emit(state.copyWith(isLoading: isLoading));

  void setupRtcLiveEventHandler() {
    liveService.setEngineEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        LogDev.one('onJoinChannelSuccess');
        if (state.liveRole == LiveRole.host && state.liveStatus == LiveSettingStatus.setupLiveInfo) return;
        setLiveStatus(LiveSettingStatus.live);
      },
      onRejoinChannelSuccess: (RtcConnection connection, int elapsed) {
        LogDev.one('onRejoinChannelSuccess');
        setLiveStatus(LiveSettingStatus.live);
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        setAudienceId(remoteUid);
        LogDev.one('onUserJoined');
      },
      onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
        LogDev.one('onUserOffline');
        liveService.agoraEngine.leaveChannel();
        liveService.agoraEngine.release();
        setAudienceId(0);
        // DNavigator.back();
      },
      onLeaveChannel: (connection, stats) {
        LogDev.one('onLeaveChannel');
        setLiveStatus(LiveSettingStatus.end);
        if (state.liveRole != LiveRole.host) {
          DNavigator.back();
          leaveLive();
        }
        liveService.resetService();
        resetState();
      },
    ));
  }

  void audienceExit() async {
    setAudienceId(0);
    liveService.audienceExit();
  }

  void leaveLive() {
    setAudienceId(0);
    setLiveStatus(LiveSettingStatus.preLive);
    liveService.leave(onLeave: () {
      stopwatch.stop();
    });
    AppConfig.context!.read<LiveCubit>().getLiveList(isInit: true);
  }

  void dispose() {
    liveService.dispose();
    stopwatch.stop();
  }

  void generateLiveToken({String roomId = '', void Function()? onSuccess}) {
    executeAction(
      action: () => _liveRepository.generateAgoraToken(roomId),
      onSuccess: (response) {
        liveService.setLiveToken(response.data!);
        onSuccess?.call();
      },
    );
  }
}
