part of '../shop.dart';

class ShopEvent extends StatelessWidget {
  const ShopEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShopTitleItem(
          title: context.text.offersAndEvents,
          prefix: Container(
            height: 15.h,
            width: 4.w,
            margin: EdgeInsets.only(right: 9.w),
            decoration: BoxDecoration(
              color: AppCustomColor.orangeF1,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          onTap: () {
            context.read<EventCubit>().getEvents(isInit: true);
            DNavigator.goNamed(RouteNamed.offersAndEvents);
          },
        ),
        4.verticalSpace,
        BlocBuilder<StoreHomeCubit, StoreHomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  16.horizontalSpace,
                  ...state.storeHome.events.map((e) => OffersAndEventsItem(image: e.image)),
                ],
              ),
            );
          },
        ),
        14.verticalSpace,
      ],
    );
  }
}
