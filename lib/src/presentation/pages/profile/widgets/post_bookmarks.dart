part of '../profile.dart';

class PostBookmarks extends StatelessWidget {
  final bool isLoading;
  final List<Post> posts;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onFetch;
  const PostBookmarks({
    super.key,
    this.isLoading = false,
    this.posts = const [],
    required this.onRefresh,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoading();
    }

    if (posts.isEmpty) {
      return Column(
        children: [
          20.verticalSpace,
          Image.asset(AppAsset.images.itemNotFound.path, width: 125.w),
          AppText(
            context.text.emptyList,
            style: AppStyle.textBold14,
          ),
        ],
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is! ScrollEndNotification) return false;
        if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
        onFetch();
        return true;
      },
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10).w,
          itemCount: posts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: 110.w / 132.h,
          ),
          itemBuilder: (context, index) => PostPreviewItem(post: posts[index]),
        ),
      ),
    );
  }
}
