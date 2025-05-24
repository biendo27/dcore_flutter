part of '../constants.dart';

mixin DIKey {
  //* Dio instances
  static const String dioAuthentication = 'DioAuthentication';
  static const String dioInAppUsing = 'DioInAppUsing';
  static const String dioThirdParty = 'DioThirdParty';

  //* Network configurations
  static const String networkAuthentication = 'NetworkAuthentication';
  static const String networkInAppUsing = 'NetworkInAppUsing';
  static const String networkThirdParty = 'NetworkThirdParty';

  //* Base configurations
  static const String baseUrl = 'baseUrl';
  static const String connectTimeout = 'connectTimeout';
  static const String receiveTimeout = 'receiveTimeout';
  static const String token = 'token';
  static const String refreshToken = 'refreshToken';

  //* Interceptors
  static const String appInterceptor = 'appInterceptor';
  static const String thirdPartyInterceptor = 'thirdPartyInterceptor';
  static const String authInterceptor = 'authInterceptor';

  //* Network Services
  static const String appDio = 'appDio';
  static const String thirdPartyDio = 'thirdPartyDio';
  static const String authDio = 'authDio';

  //* Route Observers
  static const String appRouterObserver = 'appRouterObserver';
  static const String homeRouterObserver = 'homeRouterObserver';
  static const String shopRouterObserver = 'shopRouterObserver';
  static const String createPostRouterObserver = 'createPostRouterObserver';
  static const String notificationRouterObserver = 'notificationRouterObserver';
  static const String profileRouterObserver = 'profileRouterObserver';
  static const String rootNavigatorKey = 'rootNavigatorKey';
  static const String shellNavigatorKey = 'shellNavigatorKey';

  //* Socket Services
  static const String socketLive = 'socketLive';

  //* Tracking Services
  static const String trackingService = 'trackingService';
  static const String firebaseAnalyticsService = 'firebaseAnalyticsService';
  static const String sentryTrackingService = 'sentryTrackingService';
  static const String noOpTrackingService = 'noOpTrackingService';
  static const String compositeTrackingService = 'compositeTrackingService';
}
