part of '../shop.dart';

class OffersAndEventsProductItem extends StatelessWidget {
  final Event event;

  const OffersAndEventsProductItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<EventCubit>().setCurrentEvent(event);
        DNavigator.goNamed(RouteNamed.offersAndEventsDetail);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 14.h),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              width: 1.sw,
              height: 105.h,
              decoration: BoxDecoration(
                color: AppColorLight.surface,
                border: Border.all(color: AppColorLight.onSurface.op(0.08)),
                boxShadow: [
                  BoxShadow(color: Colors.black.op(0.08), offset: Offset(0, 0), blurRadius: 7, spreadRadius: 0),
                ],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 108.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      event.name,
                      style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    2.verticalSpace,
                    AppText(
                      event.description,
                      style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    2.verticalSpace,
                    AppText(
                      '${context.text.to} ${event.endTime?.dateValueString ?? ''}',
                      style: AppStyle.text12.copyWith(color: AppCustomColor.blue17, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            DCachedImage(
              url: event.image,
              width: 108.w,
              height: 108.w,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ],
        ),
      ),
    );
  }
}
