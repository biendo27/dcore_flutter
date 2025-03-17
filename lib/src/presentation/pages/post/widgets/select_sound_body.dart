part of '../post.dart';

class SelectSoundBody extends StatefulWidget {
  const SelectSoundBody({super.key});

  @override
  State<SelectSoundBody> createState() => _SelectSoundBodyState();
}

class _SelectSoundBodyState extends State<SelectSoundBody> with SingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                SizedBox(width: 20.w),
                Expanded(
                  child: AppText(
                    AppConfig.context!.text.selectSound,
                    style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () => DNavigator.back(),
                  child: Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 20.sp,
                    color: AppColorLight.onSurface,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 20.h),
          // DTextField(
          //   controller: searchController,
          //   hint: '${AppConfig.context!.text.searchSound} ...',
          //   margin: EdgeInsets.symmetric(horizontal: 16.w),
          //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r)),
          //   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r)),
          //   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r)),
          //   errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r)),
          //   focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r)),
          // ),
          TabBar(
            controller: tabController,
            isScrollable: true,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
            labelStyle: AppStyle.text12,
            onTap: (index) {},
            tabs: [
              Tab(text: AppConfig.context!.text.suggested),
              Tab(text: AppConfig.context!.text.favorite),
            ],
          ),
          BlocBuilder<SoundCubit, SoundState>(
            builder: (context, state) {
              return Flexible(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SoundListBody(sounds: state.suggestedSounds.data),
                    SoundListBody(sounds: state.bookmarkedSounds.data, isFavorite: true),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
