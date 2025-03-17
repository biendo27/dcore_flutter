part of '../../livestream.dart';

class LivestreamEmployee extends StatefulWidget {
  const LivestreamEmployee({super.key});

  @override
  State<LivestreamEmployee> createState() => _LivestreamEmployeeState();
}

class _LivestreamEmployeeState extends State<LivestreamEmployee> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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

    _titleController.text = live.title;
    _descriptionController.text = live.description;

    context.read<LiveCubit>().fetchLiveOtherProduct(isInit: true);
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    AppConfig.context?.read<LiveSettingCubit>().liveService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EmployeeLivestreamAgoraView(
      titleController: _titleController,
      descriptionController: _descriptionController,
    );
  }
}
