part of '../shop.dart';

class SuggestedProductKeywords extends StatelessWidget {
  const SuggestedProductKeywords({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.currentKeyword.isNotEmpty) {
          if (state.keywords.isEmpty) return SizedBox.shrink();

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 14.h),
            itemCount: state.keywords.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return KeywordSuggestItem(
                keywordData: state.keywords[index],
                type: FindProductItemType.search,
              );
            },
          );
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 14.h),
          itemCount: state.searchHistory.histories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return KeywordSuggestItem(keywordData: state.searchHistory.histories[index]);
          },
        );
      },
    );
  }
}
