part of '../livestream.dart';

class EmployeeLivestreamAgoraView extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const EmployeeLivestreamAgoraView({
    super.key,
    required this.titleController,
    required this.descriptionController,
   });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (value, result) => context.read<LiveSettingCubit>().leaveLive(),
      child: BlocBuilder<LiveSettingCubit, LiveSettingState>(
        builder: (context, state) {
          if (state.liveStatus == LiveSettingStatus.preLive) {
            return Container(
              color: AppColorLight.shadow,
              child: AppLoading(),
            );
          }

          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Stack(
              children: [
                Container(
                  color: AppColorLight.shadow,
                  alignment: Alignment.center,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: context.read<LiveSettingCubit>().liveService.agoraEngine,
                      canvas: VideoCanvas(
                        // uid: context.read<UserCubit>().state.user.id,
                        uid: 0,
                        sourceType: VideoSourceType.videoSourceCameraPrimary,
                      ),
                    ),
                    onAgoraVideoViewCreated: (viewId) {},
                  ),
                ),
                PageView.builder(
                  controller: PageController(initialPage: 1),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox.expand();
                    }

                    if (state.liveStatus == LiveSettingStatus.setupLiveInfo) {
                      return EmployeeLivestreamPrepareUI(
                        titleController: titleController,
                        descriptionController: descriptionController,
                      );
                    }

                    return LivestreamExtendUI();
                  },
                ),
                LiveHeartSession(),
                LiveGiftSession(),
                LiveGiftRecipientSession(),
              ],
            ),
          );
        },
      ),
    );
  }
}
