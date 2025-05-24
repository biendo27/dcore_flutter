part of '../../livestream.dart';

class LivestreamPage extends StatefulWidget {
  const LivestreamPage({super.key});

  @override
  State<LivestreamPage> createState() => _LivestreamPageState();
}

class _LivestreamPageState extends State<LivestreamPage> {
  @override
  void initState() {
    super.initState();
    initLive();
  }

  void initLive() {
    WakelockPlus.enable();

    AppUser user = context.read<UserCubit>().state.user;
    Live live = context.read<LiveCubit>().state.currentLive;

    context.read<LiveSettingCubit>().initLive(user, live);
    context.read<LiveSocketCubit>()
      ..setRoomId(live.roomId)
      ..joinLive();

    context.read<LiveCommentCubit>()
      ..reset()
      ..setCurrentLive(live)
      ..fetchListComment(isInit: true);

    context.read<LiveCubit>().fetchLiveOtherProduct(isInit: true);
    context.read<LiveMissionCubit>().setCurrentLive(live);
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    AppConfig.context?.read<LiveSettingCubit>().liveService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserLivestreamAgoraView();
  }
}
