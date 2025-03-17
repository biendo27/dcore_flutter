part of '../livestream.dart';

class EmployeeLivestreamInfo extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const EmployeeLivestreamInfo({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  State<EmployeeLivestreamInfo> createState() => _EmployeeLivestreamInfoState();
}

class _EmployeeLivestreamInfoState extends State<EmployeeLivestreamInfo> {
  bool isMicMuted = false;
  String selectedFilter = "None";

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
      await engine.muteLocalAudioStream(isMicMuted);
      setState(() {
        isMicMuted = !isMicMuted;
      });
      debugPrint(isMicMuted ? "Microphone muted." : "Microphone unmuted.");
    } catch (e) {
      debugPrint("Error toggling microphone: $e");
    }
  }

  Future<void> _applyFilter(BuildContext context, String filter) async {
    final engine = context.read<LiveSettingCubit>().liveService.agoraEngine;
    try {
      setState(() {
        selectedFilter = filter;
      });
      switch (filter) {
        case "GY01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastHigh,
              lighteningLevel: 0.7,
              smoothnessLevel: 0.9,
              rednessLevel: 0.3,
            ),
          );
          break;
        case "BGY01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastNormal,
              lighteningLevel: 0.8,
              smoothnessLevel: 0.8,
              rednessLevel: 0.9,
            ),
          );
          break;
        case "NAT01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastLow,
              lighteningLevel: 0.6,
              smoothnessLevel: 1.0,
              rednessLevel: 0.1,
            ),
          );
          break;
        case "CR01":
          await engine.setBeautyEffectOptions(
            enabled: true,
            options: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.lighteningContrastHigh,
              lighteningLevel: 1.0,
              smoothnessLevel: 0.6,
              rednessLevel: 0.4,
            ),
          );
          break;
        case "PNK01":
          await engine.setBeautyEffectOptions(
              enabled: true,
              options: BeautyOptions(
                lighteningContrastLevel: LighteningContrastLevel.lighteningContrastNormal,
                lighteningLevel: 0.8,
                smoothnessLevel: 0.9,
                rednessLevel: 0.5,
              ));
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
          height: MediaQuery.of(context).size.height * 0.2,
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

  void _pinProduct() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: PinProductBody(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                context.text.title,
                style: AppStyle.text12.copyWith(color: AppColorLight.surface),
              ),
              SizedBox(height: 8.0),
              DTextField(
                controller: widget.titleController,
                hint: context.text.title,
                fillColor: AppColorLight.onSurface.op(0.6),
                inputStyle: AppStyle.text16.copyWith(color: AppColorLight.surface),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide.none),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide.none),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide.none),
              ),
              SizedBox(height: 16.0),
              AppText(
                context.text.description,
                style: AppStyle.text12.copyWith(color: AppColorLight.surface),
              ),
              SizedBox(height: 8.0),
              DTextField(
                controller: widget.descriptionController,
                hint: context.text.description,
                type: DTextInputType.multiline,
                maxLines: 4,
                fillColor: AppColorLight.onSurface.op(0.6),
                inputStyle: AppStyle.text16.copyWith(color: AppColorLight.surface),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
              ),
            ],
          ),
          Positioned(
            right: 16.0,
            top: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'switch_camera',
                  onPressed: () => _checkAndSwitchCamera(context),
                  child: Icon(Icons.cameraswitch),
                ),
                SizedBox(height: 16.0),
                FloatingActionButton(
                  heroTag: 'toggle_mic',
                  onPressed: () => _toggleMicrophone(context),
                  child: Icon(isMicMuted ? Icons.mic_off : Icons.mic),
                ),
                SizedBox(height: 16.0),
                FloatingActionButton(
                  heroTag: 'beauty_filter',
                  onPressed: () => _showBeautyFilterMenu(context),
                  child: Icon(Icons.face_retouching_natural),
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: _pinProduct,
                  child: Column(
                    children: [
                      SvgPicture.asset(AppAsset.svg.bag, width: 25.w, height: 25.w),
                      4.verticalSpace,
                      AppText(context.text.product, style: AppStyle.text12.copyWith(color: AppColorLight.surface)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
