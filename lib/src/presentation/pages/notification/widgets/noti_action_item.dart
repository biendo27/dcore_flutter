part of '../notification.dart';

class NotiActionItem extends StatelessWidget {
  final String leading;
  final String title;
  final AppNotification appNotification;
  final AppSystemNotification systemNotification;
  final void Function()? onTap;

  const NotiActionItem({
    super.key,
    required this.leading,
    this.title = '',
    AppNotification? appNotification,
    AppSystemNotification? systemNotification,
    this.onTap,
  })  : appNotification = appNotification ?? const AppNotification(),
        systemNotification = systemNotification ?? const AppSystemNotification();

  String get messageContent {
    if (systemNotification.newsTitle.isNotEmpty) {
      return systemNotification.newsTitle;
    }
    if (appNotification.message.isEmpty) return AppConfig.context!.text.noNewAnnouncementYet;
    if (appNotification.type == NotificationType.commentPost) {
      return '${appNotification.userName} ${appNotification.message} ${appNotification.comment}';
    }
    return '${appNotification.userName} ${appNotification.message}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(leading, width: 50.w, height: 50.w),
      title: AppText(title, style: AppStyle.textBold14),
      subtitle: AppText(messageContent, style: AppStyle.text14),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
