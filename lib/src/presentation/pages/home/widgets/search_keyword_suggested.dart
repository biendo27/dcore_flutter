part of '../home.dart';


class SearchKeywordSuggested extends StatelessWidget {
  const SearchKeywordSuggested({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.currentKeyword.isNotEmpty) {
          if (state.keywords.isEmpty) return Flexible(child: NoData());

          return Flexible(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              itemCount: state.keywords.length,
              itemBuilder: (context, index) {
                return KeywordSuggestItem(
                  keywordData: state.keywords[index],
                  type: FindProductItemType.search,
                  searchType: SearchType.user,
                );
              },
            ),
          );
        }

        return Flexible(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            itemCount: state.searchHistory.histories.length,
            itemBuilder: (context, index) {
              return KeywordSuggestItem(
                keywordData: state.searchHistory.histories[index],
                type: FindProductItemType.history,
                searchType: SearchType.user,
              );
            },
          ),
        );
      },
    );
  }
}