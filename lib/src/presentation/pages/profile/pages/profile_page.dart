part of '../profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabItemType.values.length,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => context.read<UserCubit>().initProfilePage(),
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  surfaceTintColor: AppColorLight.surface,
                  leading: IconButton(
                    icon: Icon(Icons.qr_code_rounded),
                    onPressed: () => DNavigator.goNamed(RouteNamed.userQR),
                    color: AppColorLight.inversePrimary,
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.settings_rounded),
                      onPressed: () => DNavigator.goNamed(RouteNamed.setting),
                      color: AppColorLight.inversePrimary,
                    ),
                    10.horizontalSpace,
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) => UserOverviewInfo(user: state.user),
                      ),
                      10.verticalSpace,
                      WalletOverviewItem(),
                    ],
                  ),
                ),
              ];
            },
            body: SafeArea(
              child: Column(
                children: [
                  TabBar(
                    // controller: tabController,
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
                      // controller: tabController,
                      children: [
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) => UserPostBody(
                            isLoading: state.isLoading,
                            posts: state.userPosts.data,
                            onRefresh: () => context.read<UserCubit>().fetchUserPosts(isInit: true),
                            onFetch: () => context.read<UserCubit>().fetchUserPosts(),
                          ),
                        ),
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) => UserFavoriteBody(
                            isLoading: state.isLoading,
                            posts: state.userBookmarkPosts.data,
                            sounds: state.userBookmarkSounds.data,
                            products: state.userBookmarkProducts.data,
                            onRefresh: () async {
                              context.read<UserCubit>().fetchUserPostBookmark(isInit: true);
                              context.read<UserCubit>().fetchUserSoundBookmark(isInit: true);
                              context.read<UserCubit>().fetchUserProductBookmark(isInit: true);
                            },
                            onFetch: () async {
                              context.read<UserCubit>().fetchUserPostBookmark();
                              context.read<UserCubit>().fetchUserSoundBookmark();
                              context.read<UserCubit>().fetchUserProductBookmark();
                            },
                          ),
                        ),
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) => UserPostBody(
                            isLoading: state.isLoading,
                            posts: state.userLikePosts.data,
                            onRefresh: () => context.read<UserCubit>().fetchUserLikePost(isInit: true),
                            onFetch: () => context.read<UserCubit>().fetchUserLikePost(),
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
      ),
    );
  }
}
