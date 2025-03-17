part of '../widgets.dart';

class ShopBody extends StatelessWidget {
  const ShopBody({super.key});

  String badgeLabel(int number) => number > 9 ? '9+' : number.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh - MediaQuery.viewInsetsOf(context).bottom,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56.h,
            alignment: Alignment.center,
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    Center(
                      child: AppText(
                        context.text.booth,
                        style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          state.user.avatarWidget(
                            height: 25.w,
                            width: 25.w,
                          ),
                          4.horizontalSpace,
                          AppText(
                            state.user.name,
                            style: AppStyle.text10.copyWith(color: AppColorLight.onSurface),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              DNavigator.back();
                              DNavigator.goNamed(RouteNamed.order);
                            },
                            child: Icon(Icons.description_outlined, size: 20.w),
                          ),
                          20.horizontalSpace,
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  DNavigator.back();
                                  DNavigator.goNamed(RouteNamed.cart);
                                },
                                child: Badge(
                                  label: AppText(
                                    badgeLabel(state.userCart.allProductLength),
                                    style: AppStyle.text8.copyWith(color: AppColorLight.surface),
                                  ),
                                  child: Icon(Icons.add_shopping_cart_rounded, size: 24.w),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          BlocBuilder<LiveCubit, LiveState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    state.liveBooth.vouchers.length,
                    (index) => VoucherItem(voucher: state.liveBooth.vouchers[index]),
                  ),
                ),
              );
            },
          ),
          10.verticalSpace,
          Expanded(
            child: BlocBuilder<LiveCubit, LiveState>(
              builder: (context, state) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.liveBooth.products.length,
                  padding: EdgeInsets.only(top: 10.h),
                  itemBuilder: (context, index) {
                    return ListProductItem(product: state.liveBooth.products[index]);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
