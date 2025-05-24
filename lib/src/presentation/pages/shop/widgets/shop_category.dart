part of '../shop.dart';

class ShopCategory extends StatelessWidget {
  const ShopCategory({super.key});

  String getTitle(BuildContext context, int index) {
    return switch (index) {
      0 => context.text.order,
      1 => context.text.voucher,
      2 => context.text.gift,
      3 => context.text.review,
      4 => context.text.address,
      5 => context.text.payment,
      6 => context.text.policyTitle,
      7 => context.text.support,
      _ => '',
    };
  }

  IconData getIcon(int index) {
    return switch (index) {
      0 => Icons.receipt,
      1 => Icons.discount,
      2 => Icons.card_giftcard,
      3 => Icons.reviews,
      4 => Icons.add_location,
      6 => Icons.stars,
      7 => Icons.message,
      8 => Icons.favorite,
      _ => Icons.help,
    };
  }

  void Function() getOnTap(
    int index,
    BuildContext context,
  ) {
    return switch (index) {
      0 => () => DNavigator.goNamed(RouteNamed.order),
      1 => () {
          _viewFullVoucher();
        },
      2 => () {
          DNavigator.goNamed(RouteNamed.giftShop);
        },
      3 => () {
          AppConfig.context!.read<OrderReviewCubit>()
            ..fetchUserReview(isInit: true)
            ..fetchProductPendingReview(isInit: true);
          DNavigator.goNamed(RouteNamed.userReview);
        },
      4 => () => DNavigator.goNamed(RouteNamed.deliveryAddress),
      5 => () => DNavigator.goNamed(RouteNamed.shopPaymentMethod),
      6 => () => DNavigator.goNamed(RouteNamed.termsOfPurchaseSalePolicy),
      7 => () {
          if (kDebugMode) {
            DNavigator.goNamed(RouteNamed.support);
            return;
          }
          DNotiMessage.featureInDevelopment();
        },
      _ => () {},
    };
  }

  void _viewFullVoucher() {
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: ListVoucherProductBody(type: VoucherType.product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          7,
          (index) => GestureDetector(
            onTap: getOnTap(index, context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Icon(getIcon(index), size: 24, color: Colors.black),
                  SizedBox(height: 4),
                  Text(getTitle(context, index), style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
