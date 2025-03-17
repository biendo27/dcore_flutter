part of '../services.dart';

@lazySingleton
class LiveService {
  late RtcEngine agoraEngine;
  RtcEngineEventHandler? engineEventHandler;
  LiveRole _liveRole = LiveRole.host;
  String _appId = '';
  String _channelId = '';
  int _uId = 0;
  String _liveToken = '';
  LiveService() : agoraEngine = createAgoraRtcEngine();

  void resetService() {
    _liveRole = LiveRole.host;
    _channelId = '';
    _uId = 0;
    _liveToken = '';
  }

  void setAgoraEngine(RtcEngine engine) => agoraEngine = engine;
  void setEngineEventHandler(RtcEngineEventHandler handler) => engineEventHandler = handler;
  void setAppId(String appId) => _appId = appId;
  void setLiveRole(LiveRole role) => _liveRole = role;
  void setChannelId(String channelId) => _channelId = channelId;
  void setUId(int uid) => _uId = uid;
  void setLiveToken(String liveToken) => _liveToken = liveToken;

  void setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    // create an instance of the Agora engine
    // agoraEngine = createAgoraRtcEngine();

    await agoraEngine.initialize(RtcEngineContext(
      appId: _appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    // Set the video configuration
    VideoEncoderConfiguration videoConfig = VideoEncoderConfiguration(
      frameRate: AgoraConstant.liveFrameRate,
      dimensions: VideoDimensions(
        width: AgoraConstant.liveWeight,
        height: AgoraConstant.liveHeight,
      ),
    );

    // Apply the configuration
    await agoraEngine.setVideoEncoderConfiguration(videoConfig);

    await agoraEngine.enableVideo();

    await agoraEngine.setBeautyEffectOptions(
      enabled: true,
      options: BeautyOptions(
        lighteningContrastLevel: LighteningContrastLevel.lighteningContrastHigh, // Tăng độ tương phản sáng cao
        lighteningLevel: 0.7, // Làm sáng da vừa phải
        smoothnessLevel: 0.9, // Mức độ làm mịn da cao
        rednessLevel: 0.3, // Tăng độ hồng cho da và môi
      ),
    );

    if (_liveRole == LiveRole.host) {
      hostJoin();
    } else {
      audienceJoin();
    }

    // Register the event handler
    if (engineEventHandler != null) {
      agoraEngine.registerEventHandler(engineEventHandler!);
    }
  }

  void hostJoin() async {
    ChannelMediaOptions options;

    options = const ChannelMediaOptions(
      autoSubscribeVideo: true,
      autoSubscribeAudio: true,
      publishCameraTrack: true,
      publishMicrophoneTrack: true,
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    );
    await agoraEngine.startPreview();
     await agoraEngine.joinChannel(
      token: _liveToken,
      channelId: _channelId,
      options: options,
      uid: _uId,
    );
  }

  void audienceJoin() async {
    ChannelMediaOptions options;

    options = const ChannelMediaOptions(
      autoSubscribeVideo: true,
      autoSubscribeAudio: true,
      publishCameraTrack: true,
      publishMicrophoneTrack: true,
      clientRoleType: ClientRoleType.clientRoleAudience,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      audienceLatencyLevel: AudienceLatencyLevelType.audienceLatencyLevelLowLatency,
    );

    await agoraEngine.joinChannel(
      token: _liveToken,
      channelId: _channelId,
      options: options,
      uid: _uId,
    );
  }

  void leave({void Function()? onLeave}) async {
    // liveStreamData();
    await agoraEngine.leaveChannel(options: const LeaveChannelOptions());

    if (_liveRole == LiveRole.host) {
      onLeave?.call();
    }

    // await agoraEngine.release();
  }

  void flipCamera() {
    agoraEngine.switchCamera();
  }

  void updateMicState(bool enableMic) {
    agoraEngine.muteLocalAudioStream(enableMic);
  }

  void audienceExit() async {
    agoraEngine.leaveChannel();
  }

  void dispose() {
    agoraEngine.unregisterEventHandler(engineEventHandler!);
  }
}
