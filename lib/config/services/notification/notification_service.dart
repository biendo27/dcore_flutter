part of '../services.dart';

mixin NotificationService {
  static void initialize() async {
    await Firebase.initializeApp(options: F.firebaseOptions);
    await AwesomeNotificationService.initialize();
    await FireBaseNotificationService.initialize();

    LogDev.data('NOTIFICATION CONFIG INITIALIZED!');
  }

  static Future<String> getDeviceToken() async => await FireBaseNotificationService.getDeviceToken();
}

mixin AwesomeNotificationService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    LogDev.info('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    LogDev.info('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    LogDev.info('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    LogDev.info('onActionReceivedMethod: $receivedAction');

    final payload = receivedAction.payload ?? {};
    if (payload["message"] != null && payload["message"] != '') {
      try {
        Map<String, dynamic> map = jsonDecode(payload["message"].toString());
        final conversation = Conversation.fromJson(map);
        DNavigator.goNamed(RouteNamed.message, extra: conversation);
      } catch (e) {
        LogDev.info(e.toString());
      }
      return;
    }

    if (payload['navigate'] != null) {
      AppConfig.context?.read<PageCubit>().navigationFromService(Uri.parse(payload['navigate'] ?? ''));
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: Duration(seconds: interval ?? 3),
              // interval: 3,
              timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}

mixin FireBaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    final fcmToken = await _firebaseMessaging.getToken();
    LogDev.data('DEVICE TOKEN: $fcmToken');
    AppGlobalValue.firebaseToken = fcmToken ?? '';

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    LogDev.data('USER GRANTED PERMISSION: ${settings.authorizationStatus}');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LogDev.data('GOT A MESSAGE WHILST IN THE FOREGROUND!\r\nMESSAGE DATA: ${message.toMap()}');

      if (message.data["notificationID"] != MessagePage.notificationID) _handleMessage(message);
    });
  }

  static int getUniqueNotificationId() {
    return DateTime.now().millisecond * DateTime.now().second * DateTime.now().minute;
  }

  static Future<String> getDeviceToken() async {
    return await _firebaseMessaging.getToken() ?? '';
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    LogDev.data("HANDLING A BACKGROUND MESSAGE: ${message.toMap()}");
    _handleMessage(message);
  }

  static void _handleMessage(RemoteMessage message) {
    LogDev.data('MESSAGE DATA: ${message.toMap()}');
    AwesomeNotificationService.showNotification(
      title: message.notification?.title ?? 'You have new notification',
      body: message.notification?.body ?? 'You have new notification',
      payload: message.data.toMapString,
    );
  }
}