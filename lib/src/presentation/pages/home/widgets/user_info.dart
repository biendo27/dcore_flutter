part of '../home.dart';

class UserInfo extends StatelessWidget {
  final Post post;
  const UserInfo({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildViewProduct(context),
            8.verticalSpace,
            _buildUserHeader(),
            8.verticalSpace,
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildViewProduct(BuildContext context) {
    if (post.product.id == 0) return const SizedBox.shrink();

    return InkWell(
      onTap: () {
        context.read<ProductCubit>().initProductData(post.product);
        DNavigator.goNamed(RouteNamed.productDetail);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColorLight.shadow.op(0.15),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: DIconText(
          spacing: 5.w,
          icon: Image.asset(AppAsset.icons.bag.path, width: 20.w, height: 20.w),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          text: context.text.viewProduct,
          textStyle: AppStyle.text14.copyWith(color: AppColorLight.onPrimary, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return InkWell(
      onTap: _viewProfille,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          post.user.avatarWidget(
            width: 40.w,
            height: 40.w,
            borderRadius: BorderRadius.circular(100.r),
          ),
          4.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                post.user.displayName,
                style: AppStyle.text14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppText(
                '@${post.user.username}',
                style: AppStyle.text10.copyWith(
                  letterSpacing: 0.6,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          if (post.user.isHost) ...[
            3.horizontalSpace,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Icon(Icons.verified, color: Colors.blue, size: 15.sp),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return SizedBox(
      width: 0.65.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DescriptionHashtagWidget(
            description: post.description,
            hashtags: post.hashtagsString,
          ),
          10.verticalSpace
        ],
      ),
    );
  }

  void _viewProfille() {
    if (post.user.id == AppConfig.context!.read<UserCubit>().state.user.id) {
      // AppConfig.context!.read<PageCubit>().setCurrentIndex(4);
      return;
    }

    AppConfig.context!.read<ProfilePreviewCubit>()
      ..reset()
      ..setCurrentUser(post.user)
      ..fetchProfile();

    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: ProfileBody(),
    );
  }
}
