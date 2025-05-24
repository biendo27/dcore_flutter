part of 'routes.dart';

mixin AppPages {
  static final GoRouter routes = GoRouter(
    navigatorKey: AppConfig.rootNaviKey,
    initialLocation: RoutePath.splash,
    debugLogDiagnostics: true,
    observers: [AppConfig.appRouterObserver],
    routes: $appRoutes,
  );
}
