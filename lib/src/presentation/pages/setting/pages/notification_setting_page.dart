part of '../setting.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  final ValueNotifier<bool> _notificationsEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _initNotificationStatus();
  }

  @override
  void dispose() {
    _notificationsEnabled.dispose();
    super.dispose();
  }

  Future<void> _initNotificationStatus() async {
    final isEnabled = await NotificationSettingService().checkPermission();
    _notificationsEnabled.value = isEnabled;
  }

  Future<void> _handleNotificationToggle(bool value) async {
    DNavigator.back();
    final isEnabled = await NotificationSettingService().handleToggle(value);
    _notificationsEnabled.value = isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.notification,
      body: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _notificationsEnabled,
            builder: (context, isEnabled, _) {
              return ListTile(
                title: AppText(
                  context.text.pushNotifications,
                  style: AppStyle.textBold16,
                ),
                trailing: Switch(
                  value: isEnabled,
                  onChanged: _handleNotificationToggle,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
