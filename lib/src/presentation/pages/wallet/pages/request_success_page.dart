part of '../wallet.dart';

class RequestSuccessPage extends StatelessWidget {
  final int id;
  const RequestSuccessPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      canBack: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.sp),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Image.asset(AppAsset.images.successGreen.path, width: 1.sw, height: 319.h),
                  ),
                  20.verticalSpace,
                  AppText(
                    context.text.sendRequestSuccess,
                    style: AppStyle.text16.copyWith(fontWeight: FontWeight.w600),
                  ),
                  AppText(
                    context.text.pleaseWaitAdminConfirmation,
                    maxLines: 2,
                    style: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: DButton(
                    onPressed: () {
                      DNavigator.newRoutesNamed(RouteNamed.home);
                    },
                    backgroundColor: AppCustomColor.greyF5,
                    textColor: Colors.black,
                    text: context.text.backToHome,
                  ),
                ),
                23.horizontalSpace,
                Expanded(
                  child: DButton(
                    onPressed: () {
                      DNavigator.goNamed(RouteNamed.transactionDetails, extra: id);
                    },
                    backgroundColor: AppCustomColor.orangeF1,
                    text: context.text.viewDetail,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
