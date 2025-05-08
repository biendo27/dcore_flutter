part of '../livestream.dart';

class LivestreamBottomView extends StatefulWidget {
  final LiveRole liveRole;

  const LivestreamBottomView({
    super.key,
    this.liveRole = LiveRole.host,
  });

  @override
  State<LivestreamBottomView> createState() => _LivestreamBottomViewState();
}

class _LivestreamBottomViewState extends State<LivestreamBottomView> {
  final TextEditingController _commentController = TextEditingController();
  String selectedFilter = "None";
  bool isMicMuted = false;
  final ValueNotifier<bool> _isKeyboardVisibleNotifier = ValueNotifier(false);
  final FocusNode _focusNode = FocusNode();
  bool isMirrorModeEnabled = false; // Mặc định bật gương

  List<VideoConfig> videoConfigs = [
    VideoConfig(
      dimensions: VideoDimensions(width: 320, height: 240), // Low
      frameRate: 15,
      bitrate: 150,
    ),
    VideoConfig(
      dimensions: VideoDimensions(width: 640, height: 360), // SD
      frameRate: 30,
      bitrate: 500,
    ),
    VideoConfig(
      dimensions: VideoDimensions(width: 1280, height: 720), // HD
      frameRate: 30,
      bitrate: 1000,
    ),
    VideoConfig(
      dimensions: VideoDimensions(width: 1920, height: 1080), // Full HD
      frameRate: 30,
      bitrate: 1500,
    ),
  ];

  final List<String> _emojis = [
    "😀",
    "😂",
    "😍",
    "😭",
    "🥺",
    "😎",
    "😡",
    "👍",
    "👎",
    "🙏",
    "❤️",
    "🔥",
    "🎉",
    "🎁",
    "💯",
    "🤔",
    "😴",
    "🙄",
    "🎶",
    "🤑",
    "🤗",
    "🙌",
    "👀",
    "🥳",
    "😀",
    "😃",
    "😄",
    "😁",
    "😆",
    "😅",
    "😂",
    "🤣",
    "😊",
    "😇",
    "🙂",
    "🙃",
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      _isKeyboardVisibleNotifier.value = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _sendGiftTap(BuildContext context) {
    int liveId = context.read<LiveCubit>().state.currentLive.id;
    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: GiftBody(
        typeId: liveId,
        giftType: GiftType.live,
        onSendGift: (gift) {},
      ),
    );
  }

  VideoConfig selectedConfig = VideoConfig(
    dimensions: VideoDimensions(width: 1280, height: 720), // Default HD
    frameRate: 30,
    bitrate: 800,
  );

  void _showVideoConfigMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.4.sh,
          child: ListView.builder(
            itemCount: videoConfigs.length,
            itemBuilder: (context, index) {
              final config = videoConfigs[index];
              return ListTile(
                title: Text(
                  "${config.dimensions.width} x ${config.dimensions.height} - ${config.frameRate} FPS - ${config.bitrate} kbps",
                ),
                onTap: () {
                  setState(() {
                    selectedConfig = config;
                  });
                  Navigator.pop(context);
                  _setupVideo();
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _setupVideo() async {
    final engine = context.read<LiveSettingCubit>().liveService.agoraEngine;

    int adjustedBitrate = selectedConfig.bitrate;
    if (selectedConfig.dimensions.width! >= 1920) {
      adjustedBitrate = (selectedConfig.bitrate * 0.8).toInt(); // Reduce bitrate for Full HD/4K
    }

    // Chỉ định codec nếu cần
    await engine.setParameters('{"che.video.codec":"H264"}'); // Codec H.264

    await engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
      dimensions: selectedConfig.dimensions,
      frameRate: selectedConfig.frameRate > 30 ? 30 : selectedConfig.frameRate, // Cap FPS at 30
      bitrate: adjustedBitrate,
      degradationPreference: DegradationPreference.maintainBalanced,
      mirrorMode: isMirrorModeEnabled ? VideoMirrorModeType.videoMirrorModeEnabled : VideoMirrorModeType.videoMirrorModeDisabled,
    ));
    engine.setLocalRenderMode(
      renderMode: RenderModeType.renderModeFit,
      mirrorMode: isMirrorModeEnabled ? VideoMirrorModeType.videoMirrorModeEnabled : VideoMirrorModeType.videoMirrorModeDisabled,
    );

    // Enable adaptive bitrate
    engine.setParameters('{"che.video.enable_adaptive_bitrate":true}');
  }

  void _toggleMirrorMode(BuildContext context) {
    setState(() {
      isMirrorModeEnabled = !isMirrorModeEnabled;
    });
    _setupVideo();
    debugPrint(isMirrorModeEnabled ? "Mirror mode enabled." : "Mirror mode disabled.");
  }

  Future<void> _applyFilter(BuildContext context, String filter) async {
    final engine = context.read<LiveSettingCubit>().liveService.agoraEngine;
    try {
      setState(() {
        selectedFilter = filter;
      });
      if (filter != "None") {
        await engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
          dimensions: VideoDimensions(width: 1280, height: 720), // Default HD
          frameRate: 30,
          bitrate: 1130, // Điều chỉnh bitrate
          degradationPreference: DegradationPreference.maintainAuto,
        ));
      } else {
        _setupVideo(); // Khôi phục cấu hình gốc
      }
      switch (filter) {
        case "GY01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastHigh,
              lighteningLevel: 0.5,
              smoothnessLevel: 0.6,
              rednessLevel: 0.7, // Tăng đỏ môi
              sharpnessLevel: 0.7,
            ),
          );
          break;
        case "BGY01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastNormal,
              lighteningLevel: 0.7,
              smoothnessLevel: 0.5,
              rednessLevel: 0.8, // Tăng đỏ môi nhiều hơn
              sharpnessLevel: 0.8,
            ),
          );
          break;
        case "NAT01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastLow,
              lighteningLevel: 0.6,
              smoothnessLevel: 0.4,
              rednessLevel: 0.6, // Tăng đỏ môi vừa phải
              sharpnessLevel: 0.6,
            ),
          );
          break;
        case "CR01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastHigh,
              lighteningLevel: 0.8,
              smoothnessLevel: 0.5,
              rednessLevel: 0.9, // Tăng đỏ môi tối đa
              sharpnessLevel: 0.9,
            ),
          );
          break;
        case "PNK01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastHigh, // Độ tương phản cao
              lighteningLevel: 0.9, // Làm sáng vừa phải
              smoothnessLevel: 0.7, // Tăng độ mịn
              rednessLevel: 1.0, // Đỏ môi tối đa
              sharpnessLevel: 1.0, // Tăng độ nét
            ),
          );
          break;
        case "None":
          await engine.setBeautyEffectOptions(
            enabled: false,
            options: BeautyOptions(),
          );
          break;
        default:
          break;
      }
      debugPrint("Filter applied: $filter");
    } catch (e) {
      debugPrint("Error applying filter: $e");
    }
  }

  void _showBeautyFilterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.op(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.2.sh,
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    _applyFilter(context, "None");
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[800],
                        ),
                        child: Icon(Icons.close, size: 40, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text("None", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _applyFilter(context, "GY01");
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("assets/images/avatar1.jpg", width: 60, height: 60),
                      ),
                      Text("GY01", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _applyFilter(context, "BGY01");
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("assets/images/avatar01.jpeg", width: 60, height: 60),
                      ),
                      Text("BGY01", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _applyFilter(context, "NAT01");
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("assets/images/avatar07.png", width: 60, height: 60),
                      ),
                      Text("NAT01", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _applyFilter(context, "CR01");
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("assets/images/avatar04.png", width: 60, height: 60),
                      ),
                      Text("CR01", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _applyFilter(context, "PNK01");
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("assets/images/avatar02.jpg", width: 60, height: 60),
                      ),
                      Text("PNK01", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void shareLiveLink() {
    Live currentLive = context.read<LiveCubit>().state.currentLive;
    String url = "https://venusshop.top/Livestream?roomId=${currentLive.roomId}&liveId=${currentLive.id}&hostId=${currentLive.user.id}";
    SharePlus.instance.share(
      ShareParams(
        text: url,
      ),
    );
  }

  void _openShopTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.45.sh,
          child: ShopBody(),
        );
      },
    );
  }

  void _openDutyTap(BuildContext context) {
    context.read<LiveMissionCubit>().getLiveMission(isInit: true);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColorLight.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.45.sh,
          child: DutyBody(),
        );
      },
    );
  }

  void _pinProduct(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.4.sh,
          child: PinProductBody(),
        );
      },
    );
  }

  // void _onSetting(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.4,
  //         child: ListView(
  //           padding: EdgeInsets.all(16.0),
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.camera_alt),
  //               title: Text(context.text.rotateCamera),
  //               onTap: () {
  //                 _checkAndSwitchCamera(context);
  //                 DNavigator.back();
  //               },
  //             ),
  //             SwitchListTile(
  //               secondary: Icon(Icons.wb_sunny),
  //               title: Text(context.text.mirror),
  //               value: isMirrorModeEnabled,
  //               onChanged: (bool value) {
  //                 _toggleMirrorMode(context);
  //                 DNavigator.back();
  //               },
  //             ),
  //             SwitchListTile(
  //               secondary: Icon(Icons.mic_off),
  //               title: Text(context.text.muteMicro),
  //               value: isMicMuted,
  //               onChanged: (bool value) {
  //                 _toggleMicrophone(context);
  //                 DNavigator.back();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.settings),
  //               title: Text(context.text.fpsCheck),
  //               onTap: () {
  //                 _showVideoConfigMenu(context);
  //                 //  DNavigator.back();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _checkAndSwitchCamera(BuildContext context) async {
    final engine = context.read<LiveSettingCubit>().liveService.agoraEngine;
    try {
      await engine.switchCamera();
      debugPrint("Camera switched successfully.");
    } catch (e) {
      debugPrint("Error switching camera: $e");
    }
  }

  Future<void> _toggleMicrophone(BuildContext context) async {
    final engine = context.read<LiveSettingCubit>().liveService.agoraEngine;
    try {
      // Cập nhật trạng thái trước khi gọi API
      final newMicState = !isMicMuted;

      await engine.muteLocalAudioStream(newMicState);

      // Sau khi thành công, cập nhật trạng thái
      setState(() {
        isMicMuted = newMicState;
      });

      debugPrint(newMicState ? "Microphone muted." : "Microphone unmuted.");
    } catch (e) {
      debugPrint("Error toggling microphone: $e");
    }
  }

  Future<void> _showEmojiPicker(BuildContext context) async {
    _isKeyboardVisibleNotifier.value = true; // Hiển thị nút gửi
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white, // Màu nền của BottomSheet
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), // Bo góc phía trên
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thanh kéo ở trên
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 10),
            // Emoji Picker
            SizedBox(
              height: 250, // Chiều cao của khu vực emoji
              child: PageView.builder(
                itemCount: 3, // Số trang (bạn có thể tùy chỉnh)
                itemBuilder: (context, pageIndex) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8, // Số emoji trên mỗi dòng
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _emojis.length, // Danh sách emoji
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          final emoji = _emojis[index];
                          _commentController.text += emoji; // Chèn emoji vào TextFormField
                          Navigator.pop(context); // Đóng BottomSheet
                        },
                        child: Center(
                          child: Text(
                            _emojis[index],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
    _isKeyboardVisibleNotifier.value = _focusNode.hasFocus || _commentController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _focusNode.hasFocus // Kiểm tra trạng thái bàn phím
            ? Colors.black.op(0.6) // Màu nền xám khi bàn phím hiển thị
            : Colors.transparent, // Màu nền đen với độ mờ// Bo góc
      ),
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20, top: 2), // Tùy chỉnh padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (widget.liveRole == LiveRole.host) {
                _pinProduct(context);
                return;
              }
              _openShopTap(context);
            },
            child: Badge(
              label: AppText(
                context.select((LiveCubit bloc) => bloc.state.currentLive.allProducts.length.getCountTime),
                style: AppStyle.text10.copyWith(color: AppColorLight.onPrimary),
              ),
              child: Image.asset(
                AppAsset.icons.bag.path,
                height: 30.w,
              ),
            ),
          ),
          10.horizontalSpace,

          // TextFormField nhập bình luận
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.2), // Chiều rộng tối thiểu
              child: SizedBox(
                height: 35, // Chiều cao cố định cho TextFormField
                child: TextFormField(
                  controller: _commentController,
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.done,
                  style: AppStyle.text12.copyWith(color: AppColorLight.onPrimary),
                  decoration: InputDecoration(
                    isDense: true, // Giảm chiều cao mặc định
                    hintText: context.text.input,
                    hintStyle: AppStyle.text12.copyWith(color: AppColorLight.onPrimary),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), // Giảm padding
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), // Bo góc
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppCustomColor.greyC8.op(0.2),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        size: 20,
                        color: _focusNode.hasFocus // Kiểm tra trạng thái bàn phím
                            ? Colors.white
                            : Colors.grey,
                      ),
                      onPressed: () {
                        _showEmojiPicker(context); // Hiển thị emoji picker
                      },
                    ),
                  ),
                  minLines: 1,
                  maxLines: 3, // Cố định số dòng
                  onFieldSubmitted: (value) {
                    if (value.isEmpty) return;
                    context.read<LiveCommentCubit>().createComment(value);
                    _commentController.clear();
                    FocusScope.of(context).unfocus(); // Đóng bàn phím
                  },
                ),
              ),
            ),
          ),

          5.horizontalSpace,

          // Hiển thị nút gửi hoặc các nút điều khiển
          ValueListenableBuilder(
              valueListenable: _isKeyboardVisibleNotifier,
              builder: (context, isKeyboardVisible, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300), // Thêm hiệu ứng chuyển đổi
                  child: isKeyboardVisible
                      ? SizedBox(
                          height: 25,
                          width: 25,
                          child: GestureDetector(
                            onTap: () {
                              if (_commentController.text.isEmpty) return;
                              context.read<LiveCommentCubit>().createComment(_commentController.text);
                              _commentController.clear();
                              FocusScope.of(context).unfocus(); // Đóng bàn phím
                            },
                            child: Image.asset(AppAsset.images.send.path, fit: BoxFit.cover),
                          ),
                        )
                      : widget.liveRole == LiveRole.host
                          ? Row(
                              spacing: 10.w,
                              children: [
                                InkWell(
                                  onTap: () => _checkAndSwitchCamera(context),
                                  child: Image.asset(AppAsset.icons.rotate.path, width: 28.w),
                                ),
                                InkWell(
                                  onTap: () => _toggleMicrophone(context),
                                  child: Image.asset(
                                    isMicMuted ? AppAsset.icons.mute.path : AppAsset.icons.voice.path,
                                    width: 28.w, // Kích thước biểu tượng nhỏ hơn
                                  ),
                                ),
                                InkWell(
                                  onTap: () => _showBeautyFilterMenu(context),
                                  child: Image.asset(AppAsset.icons.makeup.path, width: 26.w),
                                ),
                                InkWell(
                                  onTap: () => _showVideoConfigMenu(context),
                                  //onTap: () => _onSetting(context),
                                  child: Image.asset(AppAsset.icons.setting.path, width: 28.w),
                                ),
                                InkWell(
                                  onTap: shareLiveLink,
                                  child: Image.asset(AppAsset.icons.share.path, width: 28.w),
                                ),
                                InkWell(
                                  onTap: () => _toggleMirrorMode(context),
                                  child: Image.asset(
                                    isMirrorModeEnabled ? AppAsset.icons.mirror.path : AppAsset.icons.mirror.path,
                                    width: 28.w, // Kích thước biểu tượng nhỏ hơn
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              spacing: 10.w,
                              children: [
                                InkWell(
                                  child: Image.asset(AppAsset.gif.gift.path, width: 35.w),
                                  onTap: () => _sendGiftTap(context),
                                ),
                                InkWell(
                                  child: Image.asset(AppAsset.images.commission.path, width: 25.w),
                                  onTap: () => _openDutyTap(context),
                                ),
                                InkWell(
                                  child: Image.asset(AppAsset.images.wheel.path, width: 30.w),
                                  onTap: () {
                                    context.read<LiveMissionCubit>().goWhellWebView();
                                  },
                                ),
                                BlocBuilder<UserCubit, UserState>(
                                  builder: (context, state) {
                                    if (!state.user.isCensor) return const SizedBox.shrink();
                                    return InkWell(
                                      child: Image.asset(AppAsset.images.shield.path, width: 30.w),
                                      onTap: () {
                                        Live currentLive = context.read<LiveCubit>().state.currentLive;
                                        context.read<LiveCensorCubit>().getLiveCensorForm(currentLive.id);
                                      },
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: shareLiveLink,
                                  child: Image.asset(AppAsset.icons.share.path, width: 28.w),
                                ),
                              ],
                            ),
                );
              }),
        ],
      ),
    );
  }
}

class VideoConfig {
  final VideoDimensions dimensions;
  final int frameRate;
  final int bitrate;

  VideoConfig({
    required this.dimensions,
    required this.frameRate,
    required this.bitrate,
  });
}
