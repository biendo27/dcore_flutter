part of '../shop.dart';

class ProductBottomAction extends StatelessWidget {
  const ProductBottomAction({super.key});

  void _buyNow(BuildContext context) {
    Product product = context.read<ProductCubit>().state.currentProductDetail.product;
    context.read<CartCubit>().setProductCart(product);
    context.read<CartCubit>().getProductByVariant(product.attributes.map((e) => e.values.first).toList());
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: CartPopupBody(type: CartPopupType.buyNow),
    );
  }

  void _addToCart(BuildContext context) {
    Product product = context.read<ProductCubit>().state.currentProductDetail.product;
    context.read<CartCubit>().setProductCart(product);
    context.read<CartCubit>().getProductByVariant(product.attributes.map((e) => e.values.first).toList());
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: CartPopupBody(type: CartPopupType.addToCart),
    );
  }

  @override
  Widget build(BuildContext context) {
    Product product = context.read<ProductCubit>().state.currentProductDetail.product;
    return Container(
      color: Color(0xFF00A78E),
      margin: EdgeInsets.only(
        bottom: 20.w,
      ),
      child: Row(
        children: [
          20.horizontalSpace,
          BlocBuilder<OrderListCubit, OrderListState>(
            builder: (context, state) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<OrderListCubit>().fetchOrderList(isInit: true);
                      context.read<OrderListCubit>()
                        ..setCurrentOrder(state.userOrders.data.first)
                        ..fetchOrderDetail();
                      state.currentOrder.status.name.isNotEmpty
                          ? context.read<MessageCubit>().onChatStore(state.currentOrder.store.user2)
                          : context.read<MessageCubit>().onChatStore(product.store.user2);
                      debugPrint('${state.currentOrder.store.user2}');
                    },
                    child: SvgPicture.asset(
                      AppAsset.svg.chat,
                      width: 25.w,
                      height: 25.h,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(AppColorLight.onPrimary, BlendMode.srcIn),
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    context.text.consultation,
                    style: AppStyle.text10.copyWith(color: AppColorLight.onPrimary),
                  ),
                ],
              );
            },
          ),

          20.horizontalSpace,
          Container(
            width: 1.5,
            height: 30,
            color: AppColorLight.onSurfaceVariant,
          ),
          10.horizontalSpace,
          Column(
            children: [
              InkWell(
                onTap: () => _addToCart(context),
                child: Image.asset(
                  AppAsset.images.carts.path,
                  height: 30.w,
                  width: 30.w,
                  fit: BoxFit.cover,
                  color: AppColorLight.onPrimary,
                ),
              ),
              2.verticalSpace,
              Text(
                context.text.addToCart,
                style: AppStyle.text10.copyWith(color: AppColorLight.onPrimary),
              ),
            ],
          ),
          10.horizontalSpace,
          Expanded(
              child: GestureDetector(
            onTap: () => _buyNow(context),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppCustomColor.gradientButton),
              ),
              child: Center(
                child: Text(
                  context.text.buyNow,
                  style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                ),
              ),
            ),
          )),
          // GradientButton(
          //   onPressed: () => _buyNow(context),
          //   text: context.text.buyNow,
          //   size: Size(200.w, 50.h),
          //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   expandedFlex: 1,
          //   style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
          // )
        ],
      ),
    );
  }
}

// Usage example in a Scaffold
