part of '../home.dart';

class PostIntroItem extends StatelessWidget {
  final Post post;
  const PostIntroItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<PostCubit>().previewPost(post),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorLight.surface,
          borderRadius: BorderRadius.circular(16.sp),
          border: Border.all(color: AppColorLight.outlineVariant, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                DCachedImage(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                  url: post.thumbnail,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColorLight.onSurface.op(0.4),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye, color: AppColorLight.surface, size: 16),
                        SizedBox(width: 4),
                        AppText(
                          post.videoViewCount.toString(),
                          style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColorLight.surface,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(post.description, style: AppStyle.text10),
                  3.verticalSpace,
                  Row(
                    children: [
                      DCachedImage(
                        url: post.user.image,
                        borderRadius: BorderRadius.circular(100),
                        width: 25.w,
                        height: 25.w,
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(post.user.name, style: AppStyle.textBold10),
                            AppText(post.user.username, style: AppStyle.text10),
                          ],
                        ),
                      ),
                      AppText(
                        post.user.totalLikes.toString(),
                        style: AppStyle.text10.copyWith(color: AppColorLight.outlineVariant),
                      ),
                      4.horizontalSpace,
                      Icon(
                        Icons.favorite_outline_rounded,
                        color: AppColorLight.outlineVariant,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
