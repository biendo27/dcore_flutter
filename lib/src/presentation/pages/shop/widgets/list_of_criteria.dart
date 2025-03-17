part of '../shop.dart';

class ListOfCriteria extends StatelessWidget {
  final List<AttributeValue> items;
  final ValueNotifier<AttributeValue> attributeNotifier;
  final List<ValueNotifier<AttributeValue>> attributeNotifiers;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;

  const ListOfCriteria({
    super.key,
    required this.items,
    required this.attributeNotifier,
    required this.attributeNotifiers,
    required this.width,
    this.padding,
    this.height,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (int i = 0; i < items.length; i++)
          ValueListenableBuilder(
            valueListenable: attributeNotifier,
            builder: (context, value, child) {
              return ListOfCriteriaItem(
                width: width,
                item: items[i].value,
                isSelected: attributeNotifier.value == items[i],
                height: height,
                padding: padding,
                fontSize: fontSize,
                fontWeight: fontWeight,
                onTap: () {
                  attributeNotifier.value = items[i];
                  List<AttributeValue> attributes = attributeNotifiers.map((e) => e.value).toList();
                  context.read<CartCubit>().getProductByVariant(attributes);
                },
              );
            },
          ),
      ],
    );
  }
}

class ListOfCriteriaItem extends StatelessWidget {
  final double width;
  final double? height;
  final String item;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isSelected;
  final Function()? onTap;

  const ListOfCriteriaItem({
    super.key,
    required this.width,
    required this.item,
    required this.isSelected,
    this.padding,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 35.h,
        width: width,
        constraints: BoxConstraints(minWidth: width),
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: isSelected ? AppCustomColor.orangeF1 : AppCustomColor.greyF5,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: AppText(
          item,
          style: AppStyle.text12.copyWith(
            fontSize: fontSize ?? 12.sp,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: isSelected ? AppColorLight.surface : AppColorLight.onSurface,
          ),
        ),
      ),
    );
  }
}
