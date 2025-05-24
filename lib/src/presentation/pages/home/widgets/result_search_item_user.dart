part of '../home.dart';

class ResultSearchItemUser extends StatelessWidget {
  final AppUser user;
  const ResultSearchItemUser({super.key, required this.user});

  String followingText(BuildContext context) {
    if (user.isFollowedMe) return context.text.message;
    if (user.isFollowedByUser) return context.text.following;
    return context.text.follow;
  }

  String trailingText(BuildContext context) {
    return user.isFollowedByUser ? context.text.message : context.text.follow;
  }

  Color? get trailingColor {
    return user.isFollowedByUser ? AppCustomColor.greyDA : null;
  }

  void Function() follow(BuildContext context) {
    return () {
      if (AppGlobalValue.accessToken.isEmpty) {
        DNavigator.goNamed(RouteNamed.noAuth);
        return;
      }

      if (user.isFollowedByUser) {
        context.read<MessageCubit>().onChatProfile(user);
        return;
      }
      context.read<HomeSearchCubit>().updateUserFollow(user.id);
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppConfig.context!.read<ThemeCubit>().state.themeMaterial;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          user.avatarWidgetAction(
            width: 40.w,
            height: 40.w,
            borderRadius: BorderRadius.circular(40.w / 2),
            onTap: () {
              if (AppGlobalValue.accessToken.isEmpty) {
                DNavigator.goNamed(RouteNamed.noAuth);
                return;
              }
              if (user.id == AppConfig.context!.read<UserCubit>().state.user.id) return;
              AppConfig.context!.read<ProfilePreviewCubit>()
                ..reset()
                ..setCurrentUser(user);
              DNavigator.goNamed(RouteNamed.profilePreview);
            },
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  user.name,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                5.verticalSpace,
                AppText(
                  '@${user.username}',
                  style: AppStyle.text12,
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          DButton(
            onPressed: follow(context),
            text: trailingText(context),
            size: Size(71.w, 28.w),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5).w,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.sp))),
            style: AppStyle.text14.copyWith(color: theme.colorScheme.onPrimary),
            backgroundColor: trailingColor,
          ),
        ],
      ),
    );
  }
}
