part of '../shop.dart';

class FilterOptionItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  final Function()? onTap;

  const FilterOptionItem({
    super.key,
    required this.item,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.h,
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: isSelected ? AppCustomColor.orangeF1 : AppCustomColor.greyF5,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: AppText(
          item,
          style: AppStyle.text12.copyWith(
            fontSize: 12.sp,
            color: isSelected ? AppColorLight.surface : AppColorLight.onSurface,
          ),
        ),
      ),
    );
  }
}
