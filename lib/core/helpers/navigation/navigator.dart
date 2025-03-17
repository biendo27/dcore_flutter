part of '../helpers.dart';

Color getBackgroundColor(ToastType? type) {
  Map<ToastType, Color> map = {
    ToastType.success: Colors.green,
    ToastType.danger: Colors.red,
    ToastType.warning: Colors.orange,
    ToastType.normal: Colors.grey,
  };

  return map[type] ?? Colors.grey;
}

enum ToastType { normal, success, danger, warning }

mixin DNavigator {
  static void back([Object? result]) {
    if (!AppConfig.context!.canPop()) return;
    GoRouter.of(AppConfig.context!).pop(result);
  }

  static void backUntil(String page) {
    Navigator.popUntil(
      AppConfig.context!,
      (route) => route.settings.name == page,
    );
  }

  static Future<T?>? backUntilAndGo<T extends Object>(
    String pageBack,
    String pageGo, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    GoRouter.of(AppConfig.context!).go(Uri(path: pageBack, queryParameters: queryParameters).toString());
    return GoRouter.of(AppConfig.context!).push(Uri(path: pageGo, queryParameters: queryParameters).toString(), extra: extra);
  }

  static Future<T?>? backUntilAndGoNamed<T>(
    String pageBack,
    String pageGo, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    GoRouter.of(AppConfig.context!).goNamed(pageBack, pathParameters: pathParameters, queryParameters: queryParameters);
    return GoRouter.of(AppConfig.context!).pushNamed(pageGo, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  static Future<T?>? go<T>(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).push(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  static Future<T?>? goNamed<T>(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).pushNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  void to(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    GoRouter.of(AppConfig.context!).go(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  static Future<T?>? toNamed<T>(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).pushNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  static Future<T?>? pushReplacement<T>(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).pushReplacement(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  static Future<T?>? pushReplacementNamed<T>(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).pushReplacementNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  static Future<T?>? replace<T>(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).replace(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  static Future<T?>? replaceNamed<T>(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).replaceNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  // New routes in this case mean route not in current stack of navigator
  // or 'page' is first page of current stack of navigator
  // This function will clear all current stack and push new route
  // Otherwise, use backUntil to back to previous route
  static void newRoutes<T>(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).go(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  // New routes in this case mean route not in current stack of navigator
  // or 'pageName' is first page of current stack of navigator
  // This function will clear all current stack and push new route
  // Otherwise, use backUntil to back to previous route
  static void newRoutesNamed<T>(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(AppConfig.context!).goNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }
}

extension DNavigatorHelper on BuildContext {
  void back<T extends Object>([T? result]) {
    if (canPop()) pop(result);
  }

  void backUntil(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return go(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  void backUntilNamed(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return goNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  Future<T?>? backUntilAndGo<T extends Object>(
    String pageBack,
    String pageGo, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    go(Uri(path: pageBack, queryParameters: queryParameters).toString(), extra: extra);
    return push(Uri(path: pageGo, queryParameters: queryParameters).toString(), extra: extra);
  }

  Future<T?>? backUntilAndGoNamed<T>(
    String pageBack,
    String pageGo, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    goNamed(pageBack);
    return pushNamed(pageGo, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  Future<T?>? to<T>(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return push(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  Future<T?>? toNamed<T>(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return pushNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  void replace(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return pushReplacement(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  void replaceNamed(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return pushReplacementNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  // New routes in this case mean route not in current stack of navigator
  // or 'page' is first page of current stack of navigator
  // This function will clear all current stack and push new route
  // Otherwise, use backUntil to back to previous route
  void newRoute(
    String page, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return go(Uri(path: page, queryParameters: queryParameters).toString(), extra: extra);
  }

  // New routes in this case mean route not in current stack of navigator
  // or 'pageName' is first page of current stack of navigator
  // This function will clear all current stack and push new route
  // Otherwise, use backUntil to back to previous route
  void newRouteName(
    String pageName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return goNamed(pageName, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }
}
