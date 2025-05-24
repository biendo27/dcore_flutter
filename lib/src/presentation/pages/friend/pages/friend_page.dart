part of '../friend.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late TabController tabController;
  Timer searchTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    tabController = TabController(length: UserType.values.length, vsync: this);
    tabController.animateTo(context.read<UserListCubit>().state.pageIndex);
    context.read<UserListCubit>()
      ..resetData()
      ..initData();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.newFollower,
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppCustomColor.greyF2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppCustomColor.greyF2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppCustomColor.greyF2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppCustomColor.greyF2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppCustomColor.greyF2),
            ),
            onChanged: (value) {
              searchTimer.cancel();
              searchTimer = Timer(Duration(milliseconds: 500), () {
                if (value.isEmpty) {
                  context.read<UserListCubit>().initData();
                  return;
                }
                context.read<UserListCubit>().searchUser(value);
              });
            },
          ),
          TabBar(
            controller: tabController,
            isScrollable: true,
            padding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
            labelStyle: AppStyle.text12,
            onTap: (index) {},
            tabs: UserType.values.map((e) => Tab(text: e.displayName)).toList(),
          ),
          BlocBuilder<UserListCubit, UserListState>(
            builder: (context, state) {
              return Flexible(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    UserListBody(
                      users: state.suggestUser.data,
                      userType: UserType.suggested,
                      onFetch: () => context.read<UserListCubit>().fetchSuggestUser(),
                      onRefresh: () async => context.read<UserListCubit>().fetchSuggestUser(init: true),
                    ),
                    UserListBody(
                      users: state.followerUser.data,
                      userType: UserType.follower,
                      onFetch: () => context.read<UserListCubit>().fetchFollowerUser(),
                      onRefresh: () async => context.read<UserListCubit>().fetchFollowerUser(init: true),
                    ),
                    UserListBody(
                      users: state.followingUser.data,
                      userType: UserType.following,
                      onFetch: () => context.read<UserListCubit>().fetchFollowingUser(),
                      onRefresh: () async => context.read<UserListCubit>().fetchFollowingUser(init: true),
                    ),
                    UserListBody(
                      users: state.friendUser.data,
                      userType: UserType.friend,
                      onFetch: () => context.read<UserListCubit>().fetchFriendUser(),
                      onRefresh: () async => context.read<UserListCubit>().fetchFriendUser(init: true),
                    ),
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
