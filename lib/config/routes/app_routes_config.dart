part of 'routes.dart';

@immutable
abstract class BaseRouteData extends GoRouteData {
  const BaseRouteData();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
}

abstract class BaseTransitionRouteData extends GoRouteData {
  const BaseTransitionRouteData();

  @override
  CustomTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      name: state.name,
      key: state.pageKey,
      child: buildPageWidget(context, state),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }

  Widget buildPageWidget(BuildContext context, GoRouterState state);
}
