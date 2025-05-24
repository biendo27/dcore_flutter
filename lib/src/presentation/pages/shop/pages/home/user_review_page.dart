part of '../../shop.dart';

enum UserReviewType {
  notReview,
  reviewed;

  String displayName(BuildContext context) {
    return switch (this) {
      UserReviewType.notReview => context.text.notReviewed,
      UserReviewType.reviewed => context.text.reviewed,
    };
  }
}

class UserReviewPage extends StatelessWidget {
  const UserReviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.myReview,
      isLoading: context.select((OrderReviewCubit cubit) => cubit.state.isLoading),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
              labelStyle: AppStyle.text12,
              onTap: (index) {},
              tabs: UserReviewType.values.map((e) => Tab(text: e.displayName(context))).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BlocBuilder<OrderReviewCubit, OrderReviewState>(
                    builder: (context, state) {
                      if (state.productPendingReviews.data.isEmpty) return NoData();
                      return LoadMore(
                        onLoadMore: () => context.read<OrderReviewCubit>().fetchProductPendingReview(),
                        onRefresh: () => context.read<OrderReviewCubit>().fetchProductPendingReview(isInit: true),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => 10.verticalSpace,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                          itemCount: state.productPendingReviews.data.length,
                          itemBuilder: (context, index) {
                            return UserPendingReviewItem(orderProduct: state.productPendingReviews.data[index]);
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<OrderReviewCubit, OrderReviewState>(
                    builder: (context, state) {
                      if (state.userReviews.data.isEmpty) return NoData();
                      return LoadMore(
                        onLoadMore: () => context.read<OrderReviewCubit>().fetchUserReview(),
                        onRefresh: () => context.read<OrderReviewCubit>().fetchUserReview(isInit: true),
                        child: ListView.builder(
                          itemCount: state.userReviews.data.length,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemBuilder: (context, index) {
                            return ProductEvaluateItem(
                              review: state.userReviews.data[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
