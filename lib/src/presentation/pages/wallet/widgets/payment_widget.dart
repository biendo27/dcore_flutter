part of '../wallet.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentMethod data;
  final PaymentMethod paymentMethodSelected;
  final void Function() onTap;
  const PaymentWidget({super.key, required this.data, required this.paymentMethodSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        margin: EdgeInsets.symmetric(vertical: 5.sp),
        decoration: BoxDecoration(color: paymentMethodSelected.id == data.id ? AppCustomColor.orangeF1 : Colors.white, borderRadius: BorderRadius.circular(15.sp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DCachedImage(
              url: data.image,
              height: 25.h,
              fit: BoxFit.cover,
            ),
            20.horizontalSpace,
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data.name,
                      style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600),
                    ),
                    AppText(
                      data.note,
                      style: AppStyle.text12,
                      maxLines: 2,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
