part of '../home.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    HomeSearchState homeSearchState = context.watch<HomeSearchCubit>().state;
    if (homeSearchState.users.data.isNotEmpty || homeSearchState.posts.data.isNotEmpty) {
      return SearchDataSuggested();
    }

    return SearchKeywordSuggested();
  }
}