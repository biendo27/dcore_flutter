part of '../utils.dart';

void showDYesNoDialog({
  String title = '',
  required String message,
  String yesText = '',
  String noText = '',
  EdgeInsets? insetPadding,
  required Function() onYes,
  void Function()? onNo,
}) {
  if (title.isEmpty) {
    title = AppConfig.context!.text.notification;
  }
  if (yesText.isEmpty) {
    yesText = AppConfig.context!.text.yes;
  }
  if (noText.isEmpty) {
    noText = AppConfig.context!.text.cancel;
  }

  showDDiaLog(
    AppConfig.context!,
    title: title,
    actionsPadding: EdgeInsets.zero,
    enableBackButton: false,
    insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 20).w,
    body: [
      AppText(message, style: AppStyle.text16, textAlign: TextAlign.justify, maxLines: 5),
    ],
    actions: [
      Divider(height: 1),
      IntrinsicHeight(
        child: Row(
          children: [
            AppText(
              noText,
              expandFlex: 1,
              style: AppStyle.text18,
              onTap: onNo ?? DNavigator.back,
              textAlign: TextAlign.center,
              margin: EdgeInsets.symmetric(vertical: 10.h),
            ),
            VerticalDivider(width: 1),
            AppText(
              yesText,
              expandFlex: 1,
              style: AppStyle.text18,
              onTap: onYes,
              textAlign: TextAlign.center,
              margin: EdgeInsets.symmetric(vertical: 10.h),
            ),
          ],
        ),
      ),
    ],
  );
}
