part of '../home.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  void _viewProfille(BuildContext context, AppUser user) {
    context.read<ProfilePreviewCubit>()
      ..reset()
      ..setCurrentUser(user);
      
    DNavigator.back();
    DNavigator.goNamed(RouteNamed.profilePreview);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              20.horizontalSpace,
              AppText(
                AppConfig.context!.text.viewProfile,
                expandFlex: 1,
                style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () => DNavigator.back(),
                child: Icon(
                  FontAwesomeIcons.circleXmark,
                  size: 20.sp,
                  color: AppColorLight.onSurface,
                ),
              )
            ],
          ),
        ),
        22.verticalSpace,
        BlocBuilder<ProfilePreviewCubit, ProfilePreviewState>(
          builder: (context, state) {
            if (state.isLoading) return const AppLoading();

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  DCircleAvatar(
                    url: state.user.image,
                    radius: 64,
                  ),
                  15.verticalSpace,
                  AppText(state.user.displayName, style: AppStyle.textBold18),
                  AppText(
                    '@${state.user.username}',
                    style: AppStyle.textBold14.copyWith(color: const Color.fromARGB(131, 0, 0, 0).op(0.75)),
                  ),
                  30.verticalSpace,
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        InfoItem(value: state.user.totalLikes, title: context.text.like),
                        VerticalDivider(width: 1),
                        InfoItem(value: state.user.totalFollowing, title: context.text.followed),
                        VerticalDivider(width: 1),
                        InfoItem(value: state.user.totalFollower, title: context.text.follower),
                      ],
                    ),
                  ),
                  22.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GradientButton(
                        onPressed: () => context.read<ProfilePreviewCubit>().followUser(userId: state.user.id),
                        text: state.user.isFollowedByUser ? context.text.following : context.text.follow,
                        style: AppStyle.text14.copyWith(color: Colors.white),
                        size: Size(230.w, 35.h),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                      ),
                      InkWell(
                        onTap: () => _viewProfille(context, state.user),
                        child: Row(
                          children: [
                            AppText(context.text.viewProfile, style: AppStyle.text12),
                            10.horizontalSpace,
                            Icon(Icons.arrow_forward_ios, size: 12.sp),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
