part of 'di.dart';

@module
abstract class RouteObserverModule {
  @Named(DIKey.rootNavigatorKey)
  @lazySingleton
  GlobalKey<NavigatorState> get rootNavigatorKey => GlobalKey<NavigatorState>();

  @Named(DIKey.shellNavigatorKey)
  @lazySingleton
  GlobalKey<NavigatorState> get shellNavigatorKey => GlobalKey<NavigatorState>();
  @Named(DIKey.appRouterObserver)
  @lazySingleton
  NavigatorObserver get appRouterObserver => AppRouterObserver();

  @Named(DIKey.homeRouterObserver)
  @lazySingleton
  NavigatorObserver get homeRouterObserver => HomeRouterObserver();

  @Named(DIKey.shopRouterObserver)
  @lazySingleton
  NavigatorObserver get shopRouterObserver => ShopRouterObserver();

  @Named(DIKey.createPostRouterObserver)
  @lazySingleton
  NavigatorObserver get createPostRouterObserver => CreatePostRouterObserver();

  @Named(DIKey.notificationRouterObserver)
  @lazySingleton
  NavigatorObserver get notificationRouterObserver => NotificationRouterObserver();

  @Named(DIKey.profileRouterObserver)
  @lazySingleton
  NavigatorObserver get profileRouterObserver => ProfileRouterObserver();
}
