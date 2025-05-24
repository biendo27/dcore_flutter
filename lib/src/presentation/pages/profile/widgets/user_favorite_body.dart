part of '../profile.dart';

enum UserFavoriteType {
  post,
  // sound,
  // filter,
  product;

  String title(BuildContext context) => switch (this) {
        UserFavoriteType.post => context.text.postNoun,
        // UserFavoriteType.sound => context.text.sound,
        UserFavoriteType.product => context.text.product,
      };
}

class UserFavoriteBody extends StatelessWidget {
  final bool isLoading;
  final List<Post> posts;
  final List<Sound> sounds;
  final List<MediaFilter> filters;
  final List<Product> products;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onFetch;

  const UserFavoriteBody({
    super.key,
    this.isLoading = false,
    this.posts = const [],
    this.sounds = const [],
    this.filters = const [],
    this.products = const [],
    required this.onRefresh,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoading();
    }

    return DefaultTabController(
      length: UserFavoriteType.values.length,
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            labelStyle: AppStyle.textBold12,
            unselectedLabelStyle: AppStyle.text12,
            onTap: (index) {},
            tabs: UserFavoriteType.values.map((e) => Tab(text: e.title(context))).toList(),
            indicator: const BoxDecoration(),
            dividerHeight: 0,
            indicatorWeight: 0,
            indicatorPadding: EdgeInsets.zero,
          ),
          Expanded(
            child: TabBarView(
              children: [
                PostBookmarks(
                  isLoading: isLoading,
                  posts: posts,
                  onRefresh: onRefresh,
                  onFetch: onFetch,
                ),
                // SoundBookmarks(
                //   isLoading: isLoading,
                //   sounds: sounds,
                //   onRefresh: onRefresh,
                //   onFetch: onFetch,
                // ),
                ProductBookmarks(
                  isLoading: isLoading,
                  products: products,
                  onRefresh: onRefresh,
                  onFetch: onFetch,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
