part of '../home.dart';


class SearchDataSuggested extends StatelessWidget {
  const SearchDataSuggested({super.key});

  double childAspectRatio(BuildContext context) {
    int spaceWidth = Platform.isIOS ? 65 : 50;
    double width = (MediaQuery.sizeOf(context).width - spaceWidth) / 2;
    return width.w / 256.h;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSearchCubit, HomeSearchState>(
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                15.verticalSpace,
                ...state.users.data.map((e) => ResultSearchItemUser(user: e)),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.posts.data.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.w,
                    childAspectRatio: childAspectRatio(context),
                  ),
                  itemBuilder: (context, index) => PostIntroItem(post: state.posts.data[index]),
                ),
                15.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
