part of '../profile.dart';

class SoundBookmarks extends StatelessWidget {
  final bool isLoading;
  final List<Sound> sounds;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onFetch;
  const SoundBookmarks({
    super.key,
    this.isLoading = false,
    this.sounds = const [],
    required this.onRefresh,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoading();
    }
    
    if (sounds.isEmpty) {
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
      padding: EdgeInsets.symmetric(horizontal: 16).w,
      itemCount: sounds.length,
      itemBuilder: (context, index) => SoundListItem(sound: sounds[index], isFavorite: true),
    );
  }
}
