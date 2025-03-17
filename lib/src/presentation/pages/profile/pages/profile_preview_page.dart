part of '../profile.dart';

class ProfilePreviewPage extends StatefulWidget {
  const ProfilePreviewPage({super.key});

  @override
  State<ProfilePreviewPage> createState() => _ProfilePreviewPageState();
}

class _ProfilePreviewPageState extends State<ProfilePreviewPage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: TabItemType.values.length, vsync: this);
    context.read<ProfilePreviewCubit>().initProfilePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => context.read<ProfilePreviewCubit>().initProfilePage(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: InkWell(
                  onTap: DNavigator.back,
                  child: Icon(FontAwesomeIcons.arrowLeft, size: 24.sp),
                ),
                surfaceTintColor: AppColorLight.surface,
                title: AppText(context.text.profile, style: AppStyle.text18.copyWith(fontWeight: FontWeight.w600)),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<ProfilePreviewCubit, ProfilePreviewState>(
                  builder: (context, state) => UserOverviewInfo(user: state.user),
                ),
              ),
            ];
          },
          body: SafeArea(
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: GradientTabIndicator(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
                    gradient: LinearGradient(
                      colors: AppCustomColor.gradientContainer,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    indicatorHeight: 3,
                  ),
                  tabs: TabItemType.values.map((e) => TabItem(type: e, isActive: true)).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      BlocBuilder<ProfilePreviewCubit, ProfilePreviewState>(
                        builder: (context, state) => UserPostBody(
                          isLoading: state.isLoading,
                          posts: state.userPosts.data,
                          onRefresh: () => context.read<ProfilePreviewCubit>().fetchUserPosts(isInit: true),
                          onFetch: () => context.read<ProfilePreviewCubit>().fetchUserPosts(),
                        ),
                      ),
                      BlocBuilder<ProfilePreviewCubit, ProfilePreviewState>(
                        builder: (context, state) => UserFavoriteBody(
                          isLoading: state.isLoading,
                          posts: state.userBookmarkPosts.data,
                          sounds: state.userBookmarkSounds.data,
                          products: state.userBookmarkProducts.data,
                          onRefresh: () async {
                            context.read<ProfilePreviewCubit>().fetchUserPostBookmark(isInit: true);
                            context.read<ProfilePreviewCubit>().fetchUserSoundBookmark(isInit: true);
                            context.read<ProfilePreviewCubit>().fetchUserProductBookmark(isInit: true);
                          },
                          onFetch: () async {
                            context.read<ProfilePreviewCubit>().fetchUserPostBookmark();
                            context.read<ProfilePreviewCubit>().fetchUserSoundBookmark();
                            context.read<ProfilePreviewCubit>().fetchUserProductBookmark();
                          },
                        ),
                      ),
                      BlocBuilder<ProfilePreviewCubit, ProfilePreviewState>(
                        builder: (context, state) => UserPostBody(
                          isLoading: state.isLoading,
                          posts: state.userLikePosts.data,
                          onRefresh: () => context.read<ProfilePreviewCubit>().fetchUserLikePost(isInit: true),
                          onFetch: () => context.read<ProfilePreviewCubit>().fetchUserLikePost(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
