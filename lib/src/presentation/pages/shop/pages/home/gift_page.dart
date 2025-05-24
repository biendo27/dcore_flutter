part of '../../shop.dart';

class GiftShopPage extends StatefulWidget {
  const GiftShopPage({super.key});

  @override
  State<GiftShopPage> createState() => _GiftShopPageState();
}

class _GiftShopPageState extends State<GiftShopPage> {
  @override
  void initState() {
    context.read<GiftShopCubit>().fetchGiftShopList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.listGift,
      body: BlocBuilder<GiftShopCubit, GiftShopState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: AppCustomColor.greyF5,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return GiftShopItem(
                        items: state.data[index].award,
                        giftmain: state.data[index],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
