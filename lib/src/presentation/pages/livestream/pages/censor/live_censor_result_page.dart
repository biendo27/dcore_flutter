part of '../../livestream.dart';

class LiveCensorResultPage extends StatelessWidget {
  const LiveCensorResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppUser user = context.read<UserCubit>().state.user;
    return BlocBuilder<LiveCensorCubit, LiveCensorState>(
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
                      AppText('${context.text.moderationTime}: ${DateTime.now().dateTimeString}', style: AppStyle.text12),
                      3.verticalSpace,
                      AppText(context.text.moderationSuccess, style: AppStyle.textBold22),
                      3.verticalSpace,
                      DHighlightText(
                        text: context.text.moderationSuccessMessage(user.name),
                        highlights: [user.name],
                        style: AppStyle.text12,
                        highlightStyles: [AppStyle.textBold12],
                        maxLines: 10,
                      ),
                      20.verticalSpace,
                      AppText(context.text.summary, style: AppStyle.textBold16),
                      10.verticalSpace,
                      Row(
                        children: [
                          EndLiveInfo(
                            info: state.currentCensorResult.pointMax,
                            title: context.text.maximumScore,
                          ),
                          EndLiveInfo(
                            info: state.currentCensorResult.point,
                            title: context.text.ratingScore,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GradientButton(
                  onPressed: () => context.pop(),
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
