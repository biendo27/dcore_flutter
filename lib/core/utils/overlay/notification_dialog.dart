part of '../utils.dart';

void showDNotificationDialog(
  BuildContext context, {
  String title = 'Thông báo',
  required String message,
  String notiText = 'Đồng ý',
  Function()? onNoti,
}) {
  showDDiaLog(
    context,
    title: title,
    actionsPadding: const EdgeInsets.all(10.0),
    enableBackButton: false,
    insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    body: [
      AppText(message, style: AppStyle.text16, textAlign: TextAlign.justify),
    ],
    actions: [
      DButton(text: notiText, onPressed: onNoti ?? () => DNavigator.back()),
    ],
  );
}
