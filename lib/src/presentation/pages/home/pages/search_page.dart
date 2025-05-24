part of '../home.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  Timer searchDebounce = Timer(const Duration(milliseconds: 0), () {});

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.search,
      isLoading: context.select((SearchCubit cubit) => cubit.state.isLoading),
      onRefresh: () async {
        if (searchController.text.isEmpty) return;
        context.read<HomeSearchCubit>()
          ..setKeyword(searchController.text)
          ..searchPost()
          ..searchUser();
      },
      onLoadMore: () {
        List<Post> posts = context.read<HomeSearchCubit>().state.posts.data;
        if (posts.isEmpty) return;
        context.read<HomeSearchCubit>().searchPost(isInit: false);
      },
      body: BlocListener<HomeSearchCubit, HomeSearchState>(
        listener: (context, state) {
          if (searchController.text != state.keyword) searchController.text = state.keyword;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchTextfield(
                controller: searchController,
                margin: EdgeInsets.zero,
                onChanged: (value) {
                  searchDebounce.cancel();
                  searchDebounce = Timer(Duration(milliseconds: 800), () {
                    if (value.isEmpty) {
                      context.read<HomeSearchCubit>().reset();
                      context.read<SearchCubit>()
                        ..reset()
                        ..fetchSearchHistory();
                      return;
                    }

                    context.read<SearchCubit>()
                      ..setCurrentKeyword(value)
                      ..fetchListKeyword();

                    context.read<HomeSearchCubit>()
                      ..setKeyword(value)
                      ..searchPost()
                      ..searchUser();
                  });
                },
              ),
              SearchBody(),
            ],
          ),
        ),
      ),
    );
  }
}
