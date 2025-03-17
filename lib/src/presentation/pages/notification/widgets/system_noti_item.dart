part of '../notification.dart';

class SystemNotiItem extends StatelessWidget {
  final AppSystemNotification notification;
  const SystemNotiItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.read<ThemeCubit>().state.themeMaterial;
    return InkWell(
      onTap: () {
        context.read<NotificationCubit>().fetchNewsDetail(notification.newsId);
        DNavigator.goNamed(RouteNamed.systemNotificationDetail);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5).w,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8).w,
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  AppAsset.images.logo.path,
                  width: 25.w,
                  height: 25.w,
                ),
                5.horizontalSpace,
                AppText('VNS Shop | Hoạt động', style: AppStyle.textBold14),
                Spacer(),
                DIconText(
                  iconPosition: IconPosition.end,
                  icon: Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
                  text: context.text.viewAll,
                ),
              ],
            ),
            Divider(),
            5.verticalSpace,
            AppText(notification.newsTitle, maxLines: 3),
            5.verticalSpace,
            Row(
              children: [
                AppText(
                  notification.newsContent,
                  expandFlex: 1,
                  maxLines: 2,
                  style: AppStyle.text10.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                AppText(
                  notification.date!.adaptLocalDate,
                  style: AppStyle.text10.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
