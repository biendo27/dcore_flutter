part of '../shop.dart';

class ShopBanner extends StatelessWidget {
  const ShopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreHomeCubit, StoreHomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              state.storeHome.banners.length,
              (index) => BannerItem(
                banner: state.storeHome.banners[index],
                isFirst: index == 0,
              ),
            ),
          ),
        );
      },
    );
  }
}
