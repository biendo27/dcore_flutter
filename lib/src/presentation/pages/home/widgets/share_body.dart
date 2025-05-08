part of '../home.dart';

class ShareBody extends StatelessWidget {
  final Post post;
  final bool isPreview;
  final void Function() onDownload;
  const ShareBody({super.key, required this.post, this.isPreview = false, required this.onDownload});

  @override
  Widget build(BuildContext context) {
    final AppUser user = context.read<UserCubit>().state.user;
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                AppConfig.context!.text.share,
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
        // Padding(
        //   padding: EdgeInsets.all(20.sp),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       ShareAvatar(
        //         imagePath: AppAsset.images.myWife.path,
        //         title: AppConfig.context!.text.addNews,
        //         icon: Container(
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: AppColorLight.surface,
        //           ),
        //           child: SvgPicture.asset(
        //             AppAsset.svg.addCircle,
        //             width: 20.w,
        //             height: 20.h,
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 10.w),
        //           height: 70.h,
        //           child: ListView.builder(
        //             scrollDirection: Axis.horizontal,
        //             shrinkWrap: true,
        //             itemCount: 5,
        //             itemBuilder: (context, index) {
        //               return Padding(
        //                 padding: EdgeInsets.symmetric(horizontal: 5.w),
        //                 child: ShareAvatar(
        //                   imagePath: AppAsset.images.myWife.path,
        //                   title: "dahgit",
        //                   icon: Container(),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //       Column(
        //         children: [
        //           Container(
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: AppCustomColor.greyD9, // Màu nền tròn
        //             ),
        //             padding: EdgeInsets.all(10), // Khoảng cách giữa icon và viền tròn
        //             child: SvgPicture.asset(
        //               AppAsset.svg.search,
        //               color: AppColorLight.onSurface,
        //               width: 20.w,
        //               height: 20.h,
        //             ),
        //           ),
        //           14.verticalSpace,
        //           AppText(
        //             AppConfig.context!.text.search,
        //             style: AppStyle.text10.copyWith(color: AppColorLight.onSurface),
        //           ),
        //         ],
        //       ),
        //       5.horizontalSpace,
        //     ],
        //   ),
        // ),
        // 10.verticalSpace,
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20.sp),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       ShareIcon(imagePath: AppAsset.images.message.path, label: 'Messenger'),
        //       ShareIcon(imagePath: AppAsset.images.facebook.path, label: 'Facebook'),
        //       ShareIcon(imagePath: AppAsset.images.instagram.path, label: 'Instagram'),
        //       ShareIcon(imagePath: AppAsset.images.zalo.path, label: 'Zalo'),
        //       ShareIcon(imagePath: AppAsset.images.link.path, label: 'Sao chép liên kết'),
        //     ],
        //   ),
        // ),
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.horizontalSpace,
            ActionIcon(
              icon: Icons.share,
              label: 'Chia sẻ',
              onTap: () {
                SharePlus.instance.share(ShareParams(uri: Uri.parse(post.video)));
                DNavigator.back();
              },
            ),
            25.horizontalSpace,
            if (post.canSave) ...[
              ActionIcon(
                icon: Icons.download,
                label: 'Tải xuống',
                onTap: onDownload,
              ),
              25.horizontalSpace,
            ],
            if (post.user.id == user.id && isPreview) ...[
              ActionIcon(
                icon: Icons.delete,
                label: 'Xóa',
                onTap: () {
                  context.read<PostCubit>().deletePost(post.id, onSuccess: () {
                    AppConfig.context!.read<UserCubit>().initProfilePage();
                  });
                  DNavigator.back();
                  DNavigator.newRoutesNamed(RouteNamed.profile);
                },
              ),
              25.horizontalSpace,
            ],
            ActionIcon(
              icon: Icons.link,
              label: 'Sao chép liên kết',
              onTap: () {
                Clipboard.setData(ClipboardData(text: post.video));
                DMessage.showMessage(message: 'Đã sao chép liên kết');
                DNavigator.back();
              },
            ),
          ],
        ),
        20.verticalSpace,
      ],
    );
  }
}
