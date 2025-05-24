part of '../profile.dart';

class MediaFilterBookmarks extends StatelessWidget {
  final bool isLoading;
  final List<MediaFilter> mediaFilters;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onFetch;
  const MediaFilterBookmarks({
    super.key,
    this.isLoading = false,
    this.mediaFilters = const [],
    required this.onRefresh,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoading();
    }
    
    if (mediaFilters.isEmpty) {
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

    return ListView.builder(
      itemCount: mediaFilters.length,
      itemBuilder: (context, index) => MediaFilterItem(mediaFilter: mediaFilters[index]),
    );
  }
}
