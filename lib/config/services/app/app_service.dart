part of '../services.dart';

class AppConfig {
  AppConfig._();

  static late final GlobalKey<NavigatorState> rootNaviKey;
  static late final GlobalKey<NavigatorState> shellNaviKey;
  static late final NavigatorObserver appRouterObserver;
  static late final NavigatorObserver homeRouterObserver;
  static late final NavigatorObserver shopRouterObserver;
  static late final NavigatorObserver createPostRouterObserver;
  static late final NavigatorObserver notificationRouterObserver;
  static late final NavigatorObserver profileRouterObserver;

  static BuildContext? get context => rootNaviKey.currentContext;
  static NavigatorState? get state => rootNaviKey.currentState;
  static Widget? get widget => rootNaviKey.currentWidget;

  static void init() {
    rootNaviKey = AppDI.source.get<GlobalKey<NavigatorState>>(instanceName: DIKey.rootNavigatorKey);
    shellNaviKey = AppDI.source.get<GlobalKey<NavigatorState>>(instanceName: DIKey.shellNavigatorKey);
    appRouterObserver = AppDI.source.get<NavigatorObserver>(instanceName: DIKey.appRouterObserver);
    homeRouterObserver = AppDI.source.get<NavigatorObserver>(instanceName: DIKey.homeRouterObserver);
    shopRouterObserver = AppDI.source.get<NavigatorObserver>(instanceName: DIKey.shopRouterObserver);
    createPostRouterObserver = AppDI.source.get<NavigatorObserver>(instanceName: DIKey.createPostRouterObserver);
    notificationRouterObserver = AppDI.source.get<NavigatorObserver>(instanceName: DIKey.notificationRouterObserver);
    profileRouterObserver = AppDI.source.get<NavigatorObserver>(instanceName: DIKey.profileRouterObserver);
  }
}

mixin AppService {
  static void init(void Function() initApp) {
    _configErrorWidget();

    runZonedGuarded(
      () async {
        _configUIResponsible();
        _configNotificationService();
        _configLoading();
        _configErrorHandle();
        _configHelper();
        _configEnvironment();
        await _configService();
        initApp();
      },
      (error, stack) {
        LogDev.error('runZonedGuarded: $error \r\n $stack');
        AppDI.source.get<AppTrackingService>(instanceName: DIKey.noOpTrackingService).trackError(error, stackTrace: stack);
      },
    );
  }

  static void resetDI() async {
    await AppDI.resetDependencies();
  }

  static void _configNotificationService() {
    NotificationService.initialize();
  }

  static void _configEnvironment() async {
    await AppDI.initializeDependencies();
    AppConfig.init();
  }

  static Future<void> _configService() async {
    await HydrateBlocService.init();
    LocalStoreService.init();
    // DeepLinkService.init();
    // FlutterIsolateService.init();
    // GeolocatorService.init();
    // NotificationService.initialize();
    // UnityAdsService.init();
    // AdMobService.init();
  }

  static Future<void> _configHelper() async {
    await CameraService.initCameras();
  }

  static void _configUIResponsible() async {
    await ScreenUtil.ensureScreenSize();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  static void _configErrorWidget() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      LogDev.error('ErrorWidget.builder: ${details.exception} \r\n ${details.stack}');
      if (kDebugMode) throw details.exception;
      return Center(child: AppText('ErrorWidget.builder: ${details.exception} \r\n ${details.stack}'));
    };
  }

  static void _configErrorHandle() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      LogDev.error('FlutterError.onError: ${details.exception} \r\n ${details.stack}');
    };
  }

  static void _configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..maskType = EasyLoadingMaskType.black
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..animationDuration = const Duration(milliseconds: 200)
      ..indicatorSize = 40.0
      ..radius = 12.0
      ..progressColor = Colors.blue
      ..backgroundColor = Colors.black.op(0.8)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.op(0.2)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static bool onNavigationNotification(NavigationNotification notification) {
    // if (notification.canHandlePop) LogDev.info('onNavigationNotification: ${notification.toString()}');
    return notification.canHandlePop;
  }
}
