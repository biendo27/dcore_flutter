part of '../notification.dart';

class SystemNotificationPage extends StatelessWidget {
  const SystemNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.systemNotification,
      body: SingleChildScrollView(
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state.systemNotifications.data.isEmpty) {
              return const NoData();
            }

            return Column(
              children: state.systemNotifications.data.map((e) => SystemNotiItem(notification: e)).toList(),
            );
          },
        ),
      ),
    );
  }
}
