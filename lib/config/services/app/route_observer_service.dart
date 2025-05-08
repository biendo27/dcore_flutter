part of '../services.dart';

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}

abstract class BaseRouterObserver extends NavigatorObserver {
  final String observerName;
  BaseRouterObserver(this.observerName);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('didPush', route, previousRoute);
    onRouteChanged(route);
    onPushRoute(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('didPop', route, previousRoute);
    onRouteChanged(previousRoute);
    onPopRoute(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('didRemove', route, previousRoute);
    onRouteChanged(previousRoute);
    onRemoveRoute(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log('didReplace', newRoute, oldRoute, isReplace: true);
    onRouteChanged(newRoute);
    onReplaceRoute(newRoute, oldRoute);
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('didStartUserGesture', route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    LogDev.one('$observerName didStopUserGesture');
  }

  void _log(String action, Route<dynamic>? route, Route<dynamic>? previousRoute, {bool isReplace = false}) {
    final previousText = isReplace ? 'oldRoute' : 'previousRoute';
    LogDev.one('$observerName $action: ${route?.str}, $previousText= ${previousRoute?.str}');
  }

  // Override this to handle route changes
  void onRouteChanged(Route<dynamic>? route) {
    AppConfig.context?.read<PageCubit>().setCurrentRouteName(route?.settings.name ?? '');
  }

  void onPopRoute(Route<dynamic>? route) {
    AppConfig.context?.read<PageCubit>().removeNavigationHistory(route?.settings.name ?? '');
  }

  void onClearRoute() {
    AppConfig.context?.read<PageCubit>().clearNavigationHistory();
  }

  void onPushRoute(Route<dynamic> route) {
    AppConfig.context?.read<PageCubit>().addNavigationHistory(route.settings.name ?? '');
    // AppDI.source.get<AppTrackingService>(instanceName: DIKey.noOpTrackingService).trackScreenView(route.settings.name ?? '');
  }

  void onReplaceRoute(Route<dynamic>? newRoute, Route<dynamic>? oldRoute) {
    AppConfig.context?.read<PageCubit>().replaceNavigationHistory(newRoute?.settings.name ?? '', oldRoute?.settings.name ?? '');
    // AppDI.source.get<AppTrackingService>(instanceName: DIKey.noOpTrackingService).trackScreenView(newRoute?.settings.name ?? '');
  }

  void onRemoveRoute(Route<dynamic>? route) {
    AppConfig.context?.read<PageCubit>().removeNavigationHistory(route?.settings.name ?? '');
  }
}

class AppRouterObserver extends BaseRouterObserver {
  AppRouterObserver() : super('AppRouterObserver');
}

class HomeRouterObserver extends BaseRouterObserver {
  HomeRouterObserver() : super('HomeRouterObserver');
}

class ShopRouterObserver extends BaseRouterObserver {
  ShopRouterObserver() : super('ShopRouterObserver');
}

class CreatePostRouterObserver extends BaseRouterObserver {
  CreatePostRouterObserver() : super('CreatePostRouterObserver');
}

class NotificationRouterObserver extends BaseRouterObserver {
  NotificationRouterObserver() : super('NotificationRouterObserver');
}

class ProfileRouterObserver extends BaseRouterObserver {
  ProfileRouterObserver() : super('ProfileRouterObserver');
}
