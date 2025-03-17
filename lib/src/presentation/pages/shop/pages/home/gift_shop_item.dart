part of '../../shop.dart';

class GiftShopItem extends StatelessWidget {
  final Awards items;
  final GiftMain giftmain;
  const GiftShopItem({super.key, required this.items, required this.giftmain});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (items.type == "product") {
          context.read<ProductCubit>().initProductData(items.product);
          DNavigator.goNamed(RouteNamed.productDetail);
        }
      },
      child: Card(
        color: Colors.white,
        // margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: items.type.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    items.type == "product"
                        ? DCachedImage(
                            url: items.product.thumbnail,
                            width: 60.h,
                            height: 60.h,
                            fit: BoxFit.cover,
                          )
                        : items.type == "voucher"
                            ? DCachedImage(
                                url: items.voucher.image,
                                width: 60.h,
                                height: 60.h,
                                fit: BoxFit.cover,
                              )
                            : items.type == "coin"
                                ? Image.asset(
                                    AppAsset.images.coin.path,
                                    width: 60.h,
                                    height: 60.h,
                                  )
                                : Image.asset(
                                    AppAsset.images.wheel.path,
                                    width: 60.h,
                                    height: 60.h,
                                  ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          items.type == "product"
                              ? Text(
                                  items.product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : items.type == "voucher"
                                  ? Text(
                                      items.voucher.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : items.type == "coin"
                                      ? Text(
                                          "${context.text.happyGift} ${items.coin.toString()} Xu",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Text(
                                          "${context.text.happyGift} ${items.wheel} ${context.text.luckySpinWheel}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                          const SizedBox(height: 8),
                          // Text(
                          //   giftmain.,
                          //   style: const TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w400,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                giftmain.createdAt,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
