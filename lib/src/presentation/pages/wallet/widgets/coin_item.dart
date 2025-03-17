part of '../wallet.dart';

class CoinItem extends StatelessWidget {
  final Package package;
  final Package packageSelect;
  final bool firstDeposit;
  final Function(Package) onTap;
  const CoinItem({super.key, required this.package, required this.packageSelect, required this.onTap, required this.firstDeposit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(package),
      child: Container(
        height: 90.sp,
        width: 100.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            border: Border.all(color: packageSelect.id != package.id ? AppCustomColor.orangeFF.op(0.5) : AppCustomColor.orangeF1, width: 0.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAsset.images.dollar.path,
                  width: 15.sp,
                  height: 15.sp,
                ),
                4.horizontalSpace,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: package.coin.toString(),
                        style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
                      ),
                      if (firstDeposit == true)
                        TextSpan(
                          text: " + ${package.coinPlus}",
                          style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.orangeF1),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            AppText(
              package.price.currencyVND,
              style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
