part of '../profile.dart';

class UserOverviewInfo extends StatelessWidget {
  final AppUser user;
  const UserOverviewInfo({
    super.key,
    required this.user,
  });

  Widget get subAction {
    if (user.id != AppConfig.context!.read<UserCubit>().state.user.id) return const SizedBox.shrink();
    return Icon(FontAwesomeIcons.userPen, size: 16, color: AppColorLight.primary);
  }

  void Function()? get onSubActionTap {
    if (user.id != AppConfig.context!.read<UserCubit>().state.user.id) return null;
    return () => DNavigator.goNamed(RouteNamed.editInfo);
  }

  void _showPhotoView(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ShowPhotoView(image: user.image);
      },
    );
  }

  String get liveEventTime {
    if (user.liveEventStartAt == null || user.liveEventEndAt == null) return '';
    return user.liveEventEndAt!.diffTime(user.liveEventStartAt!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: () => _showPhotoView(context),
          child: DCircleAvatar(
            url: user.image,
            radius: 64,
            onSubActionTap: onSubActionTap,
            subAction: subAction,
          ),
        ),
        10.verticalSpace,
        AppText(user.displayName, style: AppStyle.textBold18),
        AppText(
          '@${user.username}',
          style: AppStyle.textBold14.copyWith(color: const Color.fromARGB(131, 0, 0, 0).op(0.75)),
        ),
        if (user.bio.isNotEmpty) ...[
          4.verticalSpace,
          AppText(
            user.bio,
            style: AppStyle.text14.copyWith(color: AppColorLight.shadow.op(0.75), fontWeight: FontWeight.w500),
            maxLines: 2,
          ),
        ],
        if (liveEventTime.isNotEmpty) ...[
          4.verticalSpace,
          DIconText(
            icon: Icon(
              Icons.calendar_month_outlined,
              size: 20.sp,
              color: AppCustomColor.redD0,
            ),
            text: '${context.text.liveEvent} · $liveEventTime',
            textStyle: AppStyle.textBold12.copyWith(color: AppColorLight.shadow.op(0.75), fontWeight: FontWeight.bold),
          ),
        ],
        10.verticalSpace,
        if (user.id != context.read<UserCubit>().state.user.id) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DButton(
                onPressed: () => context.read<ProfilePreviewCubit>().followUser(userId: user.id),
                text: user.isFollowedByUser ? context.text.following : context.text.follow,
                size: Size(114.w, 35.h),
                style: AppStyle.text14.copyWith(color: AppColorLight.surface),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
              10.horizontalSpace,
              DButton(
                onPressed: () => context.read<MessageCubit>().onChatProfile(user),
                backgroundColor: AppColorLight.onSurface.op(0.08),
                customChild: SvgPicture.asset(AppAsset.svg.chat, width: 16.w, height: 20.h),
                size: Size(37.w, 35.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
            ],
          ),
        ],
        15.verticalSpace,
        InkWell(
          onTap: () {
            if (user.id != context.read<UserCubit>().state.user.id) return;
          },
          child: IntrinsicHeight(
            child: Row(
              children: [
                InfoItem(
                  value: user.totalLikes,
                  title: context.text.like,
                ),
                VerticalDivider(width: 1),
                InfoItem(
                  value: user.totalFollowing,
                  title: context.text.followed,
                  onTap: () {
                    if (user.id == context.read<UserCubit>().state.user.id) {
                      context.read<UserListCubit>().setPageIndex(UserType.following.index);
                      DNavigator.goNamed(RouteNamed.friend);
                      return;
                    }
                    DNotiMessage.featureInDevelopment;
                  },
                ),
                VerticalDivider(width: 1),
                InfoItem(
                  value: user.totalFollower,
                  title: context.text.follower,
                  onTap: () {
                    if (user.id == context.read<UserCubit>().state.user.id) {
                      context.read<UserListCubit>().setPageIndex(UserType.follower.index);
                      DNavigator.goNamed(RouteNamed.friend);
                      return;
                    }
                    DNotiMessage.featureInDevelopment;
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
