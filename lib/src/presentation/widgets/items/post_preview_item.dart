part of '../widgets.dart';

class PostPreviewItem extends StatelessWidget {
  final Post post;
  const PostPreviewItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<PostCubit>().previewPost(post),
      child: Stack(
        children: [
          DCachedImage(
            borderRadius: BorderRadius.circular(10.sp),
            url: post.thumbnail,
            width: 110.w,
            height: 132.h,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.only(left: 8.w, top: 7.h),
            child: Row(
              children: [
                Icon(Icons.visibility, size: 12.sp, color: AppColorLight.surface),
                4.horizontalSpace,
                AppText(
                  post.videoViewCount.toString(),
                  style: AppStyle.text10.copyWith(color: AppColorLight.surface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
