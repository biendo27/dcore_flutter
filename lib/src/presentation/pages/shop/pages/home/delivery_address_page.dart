part of '../../shop.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({super.key});

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  @override
  void initState() {
    super.initState();
    context.read<DeliveryAddressCubit>().fetchBillingAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.deliveryAddress,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.read<DeliveryAddressCubit>()
                  ..setCurrentAddress(UserBillingAddress())
                  ..fetchNationList();
                DNavigator.goNamed(RouteNamed.newAddress);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAsset.svg.plus,
                    height: 20.h,
                    width: 20.w,
                  ),
                  10.horizontalSpace,
                  AppText(
                    context.text.addAddress,
                    style: AppStyle.text14,
                  ),
                ],
              ),
            ),
            17.verticalSpace,
            Expanded(
              child: BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.addresses.length,
                    itemBuilder: (context, index) {
                      return DeliveryAddressItem(addressData: state.addresses[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
