part of '../widgets.dart';

class NoData extends StatelessWidget {
  final String message;
  final MainAxisAlignment mainAxisAlignment;
  const NoData({super.key, this.message = '', this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    String displayMessage = message.isEmpty ? context.text.emptyList : message;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        SizedBox(width: 1.sw),
        20.verticalSpace,
        Image.asset(AppAsset.images.itemNotFound.path, width: 125.w),
        AppText(
          displayMessage,
          style: AppStyle.textBold14,
        ),
      ],
    );
  }
}
