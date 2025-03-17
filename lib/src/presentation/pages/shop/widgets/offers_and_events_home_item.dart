part of '../shop.dart';

class OffersAndEventsItem extends StatelessWidget {
  final String image;

  const OffersAndEventsItem({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<EventCubit>().getEvents(isInit: true);
        DNavigator.goNamed(RouteNamed.offersAndEvents);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        child: DCachedImage(
          borderRadius: BorderRadius.circular(15.r),
          url: image,
          height: 90.h,
        ),
      ),
    );
  }
}
