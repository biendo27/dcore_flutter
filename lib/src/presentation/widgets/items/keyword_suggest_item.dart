part of '../widgets.dart';

enum FindProductItemType {
  search,
  history,
}

enum SearchType {
  product,
  user,
}

class KeywordSuggestItem extends StatelessWidget {
  final SearchKeyword keywordData;
  final FindProductItemType type;
  final SearchType searchType;

  const KeywordSuggestItem({
    super.key,
    required this.keywordData,
    this.type = FindProductItemType.history,
    this.searchType = SearchType.product,
  });

  IconData get leadingIcon => type == FindProductItemType.history ? Icons.history : Icons.search;
  IconData get trailingIcon => type == FindProductItemType.history ? Icons.close : Icons.north_west;

  void onTap(BuildContext context) {
    if (searchType == SearchType.product) {
      context.read<ProductFilterCubit>()
        ..resetSelectedFilter()
        ..changeKeyword(keywordData.keyword)
        ..searchProduct();

      context.read<SearchCubit>()
        ..saveKeywordHistory(keywordData.keyword)
        ..setKeywords([]);

      DNavigator.replaceNamed(RouteNamed.resultFindProduct);
      return;
    }

    context.read<HomeSearchCubit>()
      ..setKeyword(keywordData.keyword)
      ..searchPost()
      ..searchUser();

    context.read<SearchCubit>()
      ..saveKeywordHistory(keywordData.keyword)
      ..setKeywords([]);

    // context.read<UserListCubit>().fetchUserList(keywordData.keyword);
    // DNavigator.replaceNamed(RouteNamed.resultFindUser);
  }

  void onRemove(BuildContext context) {
    context.read<SearchCubit>().removeKeywordHistory(keywordData);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            Icon(leadingIcon, size: 25.sp, color: AppColorLight.scrim),
            8.horizontalSpace,
            AppText(keywordData.keyword, style: AppStyle.text14, expandFlex: 1, maxLines: 1, overflow: TextOverflow.ellipsis),
            InkWell(
              onTap: () => onRemove(context),
              child: Icon(trailingIcon, size: 20.sp, color: AppColorLight.scrim),
            ),
          ],
        ),
      ),
    );
  }
}
