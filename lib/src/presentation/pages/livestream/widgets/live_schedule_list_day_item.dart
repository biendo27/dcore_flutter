part of '../livestream.dart';

class LiveScheduleListDayItem extends StatelessWidget {
  const LiveScheduleListDayItem({super.key, required this.day, required this.items});
  final String day;
  final List<LiveScheduleListItem> items;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(day, style: AppStyle.text12.copyWith(color: AppColorLight.onSurface)),
        5.verticalSpace,
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
        ),
      ],
    );
  }
}
