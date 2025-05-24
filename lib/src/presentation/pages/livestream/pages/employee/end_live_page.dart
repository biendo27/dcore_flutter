part of '../../livestream.dart';

class EndLivePage extends StatelessWidget {
  const EndLivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveCubit, LiveState>(
      builder: (context, state) {
        return SubLayout(
          enableAppBar: false,
          isLoading: state.isLoading,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      70.verticalSpace,
                      AppText('${context.text.duration}: ${state.currentLive.duration.formatDuration}', style: AppStyle.text12),
                      3.verticalSpace,
                      AppText(context.text.liveSessionCompleted, style: AppStyle.textBold22),
                      3.verticalSpace,
                      AppText(
                        context.text.liveSessionCompletionMessage(context.read<UserCubit>().state.user.name),
                        style: AppStyle.text12,
                        maxLines: 10,
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          EndLiveInfo(
                            info: state.currentLive.viewCount,
                            title: context.text.viewer,
                          ),
                          EndLiveInfo(
                            info: state.currentLive.giftsCount,
                            title: context.text.giftSender,
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          EndLiveInfo(
                            info: state.currentLive.likesCount,
                            title: context.text.likes,
                          ),
                          EndLiveInfo(
                            info: state.currentLive.soldProductsCount,
                            title: context.text.soldItems(state.currentLive.soldProductsCount),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      BlocBuilder<LiveCensorCubit, LiveCensorState>(
                        builder: (context, censorState) {
                          if (censorState.currentCensorResult.id == 0) return const SizedBox.shrink();

                          return InkWell(
                            onTap: () {
                              context.read<LiveCensorCubit>().getLiveCensorResult(state.currentLive.id);
                              DNavigator.goNamed(RouteNamed.liveCensorForm);
                            },
                            child: Row(
                              children: [
                                Image.asset(AppAsset.images.shield.path, width: 20.w, height: 20.w),
                                10.horizontalSpace,
                                AppText(context.text.contentModeration),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded, size: 15.w),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                GradientButton(
                  onPressed: () {
                    context.read<LiveCubit>().setCurrentLive(Live());
                    context.goNamed(RouteNamed.home);
                  },
                  text: context.text.backToHome,
                ),
                20.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
