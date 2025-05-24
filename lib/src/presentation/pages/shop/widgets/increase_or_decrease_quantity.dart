part of '../shop.dart';

class IncreaseOrDecreaseQuantity extends StatelessWidget {
  final ValueNotifier<int> quantityNotifier;

  const IncreaseOrDecreaseQuantity({
    super.key,
    required this.quantityNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5.w, color: AppCustomColor.greyAC),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              quantityNotifier.value--;
            },
            child: Icon(Icons.remove, size: 20.w),
          ),
          16.horizontalSpace,
          ValueListenableBuilder(
              valueListenable: quantityNotifier,
              builder: (context, value, child) {
                return AppText(
                  value.toString(),
                  style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                );
              }),
          16.horizontalSpace,
          InkWell(
            onTap: () {
              quantityNotifier.value++;
            },
            child: Icon(Icons.add, size: 20.w),
          ),
        ],
      ),
    );
  }
}

class IncreaseOrDecreaseQuantityCart extends StatelessWidget {
  final int quantity;
  final void Function() increment;
  final void Function() decrement;

  const IncreaseOrDecreaseQuantityCart({
    super.key,
    required this.quantity,
    required this.increment,
    required this.decrement,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5.w, color: AppCustomColor.greyAC),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Row(
        children: [
          InkWell(
            onTap: decrement,
            child: Icon(Icons.remove, size: 20.w),
          ),
          16.horizontalSpace,
          AppText(
            quantity.toString(),
            style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
          ),
          16.horizontalSpace,
          InkWell(
            onTap: increment,
            child: Icon(Icons.add, size: 20.w),
          ),
        ],
      ),
    );
  }
}
