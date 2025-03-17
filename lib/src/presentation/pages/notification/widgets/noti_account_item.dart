part of '../notification.dart';

class NotiAccountItem extends StatelessWidget {
  final AppNotification content;
  final bool enableTrailing;
  const NotiAccountItem({
    super.key,
    AppNotification? content,
    this.enableTrailing = true,
  }) : content = content ?? const AppNotification();

  String get trailingText {
    if (content.isFollowedByUser) return AppConfig.context!.text.message;
    return AppConfig.context!.text.followBack;
  }

  Color? get trailingColor {
    if (content.isFollowedByUser) return AppCustomColor.greyDA;
    return null;
  }

  Function() get onTap {
    if (content.isFollowedByUser) return () => AppConfig.context!.read<NotificationCubit>().goMessage(content.userId);
    return () => AppConfig.context!.read<UserListCubit>().updateUserFollow(content.userId, UserType.follower);
  }

  Widget leading(ThemeData theme) {
    if (!enableTrailing) return const SizedBox.shrink();
    return DButton(
      onPressed: onTap,
      text: trailingText,
      size: Size(71.w, 28.w),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5).w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.sp))),
      style: AppStyle.text14.copyWith(color: theme.colorScheme.onPrimary),
      backgroundColor: trailingColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.read<ThemeCubit>().state.themeMaterial;
    return ListTile(
      leading: DCachedImage(
        url: content.userImage,
        width: 50.w,
        height: 50.w,
        borderRadius: BorderRadius.circular(50.w / 2),
        onTap: () async {
          if (content.userId == AppConfig.context!.read<UserCubit>().state.user.id) return;
          AppConfig.context!.read<ProfilePreviewCubit>()
            ..reset()
            ..setCurrentUser(AppUser(id: content.userId, image: content.userImage));
          DNavigator.goNamed(RouteNamed.profilePreview);
        },
      ),
      title: AppText(content.userName, style: AppStyle.textBold14),
      subtitle: AppText(content.message, style: AppStyle.text14),
      trailing: leading(theme),
    );
  }
}
