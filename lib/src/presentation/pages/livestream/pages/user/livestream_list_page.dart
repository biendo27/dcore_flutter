part of '../../livestream.dart';

class LivestreamListPage extends StatefulWidget {
  const LivestreamListPage({super.key});

  @override
  State<LivestreamListPage> createState() => _LivestreamListPageState();
}

class _LivestreamListPageState extends State<LivestreamListPage> {
  TextEditingController searchController = TextEditingController();
  Timer searchDebounce = Timer(Duration.zero, () {});

  @override
  void initState() {
    context.read<LiveCubit>().getLiveList(isInit: true);
    context.read<DeliveryAddressCubit>().fetchBillingAddresses();
    context.read<OrderPaymentMethodCubit>().fetchPaymentMethods();
    context.read<LiveSocketCubit>().initConnection();
    super.initState();
  }

  List<Widget> get actions {
    AppUser user = context.read<UserCubit>().state.user;
    if (!user.isHost) return [];
    return [
      GradientButton(
        size: Size(110.w, 42.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
        onPressed: () {
          context.read<LiveCubit>()
            ..getMyScheduleList(isInit: true)
            ..getMyNearestLive();
          DNavigator.goNamed(RouteNamed.liveScheduleList);
        },
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        text: "Go Live",
        customChild: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAsset.images.circleButtonLight.path, width: 20.w, height: 20.w),
            5.horizontalSpace,
            AppText("Go Live", style: AppStyle.text12.copyWith(color: AppColorLight.surface)),
          ],
        ),
      ),
      15.horizontalSpace,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.livestream,
      actions: actions,
      onRefresh: () async => context.read<LiveCubit>().getLiveList(isInit: true),
      onLoadMore: () async => context.read<LiveCubit>().getLiveList(),
      onPopInvokedWithResult: (didPop, result) => context.read<LiveSocketCubit>().closeConnection(),
      onBackSuccess: () => context.read<LiveSocketCubit>().closeConnection(),
      body: Column(
        children: [
          DTextField(
            controller: searchController,
            hint: context.text.search,
            fillColor: const Color.fromRGBO(242, 242, 242, 1),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            // contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            prefix: Icon(Icons.search_rounded, size: 25.sp, color: AppColorLight.scrim),
            suffix: !kDebugMode ? null : Icon(FontAwesomeIcons.microphone, size: 20.sp, color: AppColorLight.scrim),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
            onChanged: (value) {
              searchDebounce.cancel();
              searchDebounce = Timer(const Duration(milliseconds: 1000), () {
                if (value.isEmpty) {
                  context.read<LiveCubit>().getLiveList(isInit: true);
                  return;
                }
                context.read<LiveCubit>().getLiveList(search: value);
              });
            },
          ),
          const LivestreamLiveBody(),
        ],
      ),
    );
  }
}
