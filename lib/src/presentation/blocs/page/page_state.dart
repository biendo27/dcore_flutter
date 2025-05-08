part of '../blocs.dart';

@freezed
abstract class PageState with _$PageState {
  const factory PageState({
    @Default(0) int currentIndex,
    @Default(false) bool stopAllMedia,
    @Default('') String currentRouteName,
  }) = _PageState;

  factory PageState.initial() => const PageState();
}

extension PageStateX on PageState {
  bool get isAuthenticated => AppGlobalValue.accessToken.isNotEmpty;

  bool get isPrimaryRoute => primaryRouteNames.contains(currentRouteName);

  List<String> get primaryRouteNames {
    return [
      // RouteNamed.createPost,
      RouteNamed.shellRoute,
      RouteNamed.home,
      RouteNamed.vnsShop,
      RouteNamed.notification,
      RouteNamed.profile,
    ];
  }
}
