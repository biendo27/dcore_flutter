part of '../services.dart';

class NotificationSettingService {
  static final NotificationSettingService _instance = NotificationSettingService._internal();
  factory NotificationSettingService() => _instance;
  NotificationSettingService._internal();

  Future<bool> checkPermission() async {
    if (Platform.isIOS) {
      final settings = await FirebaseMessaging.instance.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    } else {
      final status = await Permission.notification.status;
      return status.isGranted;
    }
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    } else {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
  }

  Future<void> openSettings() async {
    if (Platform.isAndroid) {
      final OpenSettingsPlusAndroid openSettings = OpenSettingsPlusAndroid();
      await openSettings.appNotification();
    } else if (Platform.isIOS) {
      final OpenSettingsPlusIOS openSettings = OpenSettingsPlusIOS();
      await openSettings.appSettings();
    }
  }

  Future<bool> handleToggle(bool value) async {
    if (value) {
      final isGranted = await requestPermission();
      if (!isGranted) {
        await openSettings();
      }
      return isGranted;
    } else {
      await openSettings();
      return await checkPermission();
    }
  }
}
