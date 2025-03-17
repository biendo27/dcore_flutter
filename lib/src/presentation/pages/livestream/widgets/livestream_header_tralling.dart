part of '../livestream.dart';

class LivestreamHeaderTralling extends StatelessWidget {
  final LiveRole liveRole;

  const LivestreamHeaderTralling({
    super.key,
    this.liveRole = LiveRole.host,
  });

  void _showExitDialog(BuildContext context) {
    showDYesNoDialog(
      title: context.text.notification,
      message: context.text.endlive,
      onYes: () {
        context
          ..read<LiveSettingCubit>().leaveLive()
          ..read<LiveSocketCubit>().leaveLive();

        if (liveRole == LiveRole.host) {
          LiveCubit live = context.read<LiveCubit>();
          int duration = context.read<LiveSettingCubit>().stopwatch.elapsed.inSeconds;

          live.endLive(duration);
          context.read<LiveCensorCubit>().getLiveCensorResult(live.state.currentLive.id);
          DNavigator.back();
          DNavigator.replaceNamed(RouteNamed.endLive);
          return;
        }

        context.read<LiveCubit>().leaveLive();
        DNavigator.back();
      },
    );
  }

  void _viewer(BuildContext context) {
    if (context.read<LiveViewerCubit>().state.viewers.isEmpty) {
      return;
    }

    showDataBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.7,
      contentPadding: EdgeInsets.zero,
      title: context.text.topViewers,
      bodyWidget: BlocBuilder<LiveViewerCubit, LiveViewerState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.viewers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => LivestreamViewer(viewer: state.viewers[index], rank: index),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: AppColorLight.shadow.op(0.1),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: DIconText(
            onTap: () => _viewer(context),
            spacing: 4,
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: AppColorLight.onPrimary,
              size: 16.w,
            ),
            text: context.select((LiveViewerCubit bloc) => bloc.state.viewers.length).toString(),
            textStyle: AppStyle.textBold10.copyWith(color: AppColorLight.onPrimary),
          ),
        ),
        InkWell(
          onTap: () => _showExitDialog(context),
          child: Icon(
            liveRole == LiveRole.host ? Icons.power_settings_new_rounded : Icons.close_rounded,
            color: AppColorLight.onPrimary,
            size: 24.w,
          ),
        ),
      ],
    );
  }
}
