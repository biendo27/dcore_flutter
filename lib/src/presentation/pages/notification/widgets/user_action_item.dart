part of '../notification.dart';

class UserActionItem extends StatelessWidget {
  final AppUser user;
  final UserType type;
  final String? subtitle;

  const UserActionItem({
    super.key,
    required this.user,
    required this.type,
    this.subtitle,
  });

  String followingText(BuildContext context) {
    if (user.isFollowedMe) return context.text.message;
    if (user.isFollowedByUser) return context.text.following;
    return context.text.follow;
  }

  String trailingText(BuildContext context) {
    return switch (type) {
      UserType.suggested => user.isFollowedByUser ? context.text.message : context.text.follow,
      UserType.follower => user.isFollowedByUser ? context.text.message : context.text.followBack,
      UserType.following => followingText(context),
      UserType.friend => context.text.message,
    };
  }

  Color? get trailingColor {
    return switch (type) {
      UserType.suggested => user.isFollowedByUser ? AppCustomColor.greyDA : null,
      UserType.follower => user.isFollowedByUser ? AppCustomColor.greyDA : null,
      UserType.following => user.isFollowedMe ? AppCustomColor.greyDA : null,
      UserType.friend => AppCustomColor.greyDA,
    };
  }

  void Function() follow({required BuildContext context, bool goMessage = false}) {
    return () {
      if (goMessage) {
        context.read<MessageCubit>().onChatProfile(user);
        return;
      }
      context.read<UserListCubit>().updateUserFollow(user.id, type);
    };
  }

  void Function() onFollowAction(BuildContext context) {
    return switch (type) {
      UserType.suggested => follow(context: context, goMessage: user.isFollowedByUser),
      UserType.follower => follow(context: context, goMessage: user.isFollowedByUser),
      UserType.following => follow(context: context, goMessage: user.isFollowedMe),
      UserType.friend => follow(context: context, goMessage: true),
    };
  }

  Widget trailing(BuildContext context, ThemeData theme) {
    Widget tmp = DButton(
      onPressed: onFollowAction(context),
      text: trailingText(context),
      size: Size(71.w, 28.w),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5).w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.sp))),
      style: AppStyle.text14.copyWith(color: theme.colorScheme.onPrimary),
      backgroundColor: trailingColor,
    );

    if (type == UserType.suggested) {
      tmp = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          tmp,
          if (type == UserType.suggested && !user.isFollowedByUser) ...[
            10.horizontalSpace,
            InkWell(
              onTap: () => context.read<UserListCubit>().removeSuggestion(user.id),
              child: Icon(FontAwesomeIcons.xmark, size: 16.sp),
            ),
          ],
        ],
      );
    }

    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppConfig.context!.read<ThemeCubit>().state.themeMaterial;

    Widget tmp = ListTile(
      leading: user.avatarWidgetAction(
        width: 45.w,
        height: 45.w,
        borderRadius: BorderRadius.circular(45.w / 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      title: AppText(user.name, style: AppStyle.textBold14),
      subtitle: subtitle != null ? AppText(subtitle!, style: AppStyle.text14) : null,
      trailing: trailing(context, theme),
    );

    if (Platform.isIOS) {
      tmp = Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: tmp,
      );
    }

    return tmp;
  }
}
