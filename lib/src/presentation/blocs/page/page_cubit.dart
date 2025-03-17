part of '../blocs.dart';

@lazySingleton
class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState.initial());
  String _serviceRouteName = '';
  Map<String, String> _serviceRouteQuery = {};
  List<String> navigationHistory = [];

  void addNavigationHistory(String routeName) {
    navigationHistory.add(routeName);
  }

  void removeNavigationHistory(String routeName) {
    navigationHistory.remove(routeName);
  }

  void clearNavigationHistory() {
    navigationHistory.clear();
  }

  void replaceNavigationHistory(String newRouteName, String oldRouteName) {
    navigationHistory.removeWhere((routeName) => routeName == oldRouteName);
    navigationHistory.add(newRouteName);
  }

  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
    // switch (index) {
    //   case 0:
    //     DNavigator.newRoutesNamed(RouteNamed.home);
    //     break;
    //   case 1:
    //     DNavigator.newRoutesNamed(RouteNamed.vnsShop);
    //     break;
    //   case 2:
    //     break;
    //   case 3:
    //     DNavigator.newRoutesNamed(RouteNamed.notification);
    //     break;
    //   case 4:
    //     DNavigator.newRoutesNamed(RouteNamed.profile);
    //     break;
    // }
  }

  void setStopAllMedia(bool isStop) => emit(state.copyWith(stopAllMedia: isStop));

  void setCurrentRouteName(String routeName) {
    if (routeName == RouteNamed.shellRoute && (state.currentRouteName == RouteNamed.noAuth || state.currentRouteName == RouteNamed.login)) {
      emit(state.copyWith(currentRouteName: RouteNamed.home));
      return;
    }

    if (routeName.isEmpty || routeName == RouteNamed.shellRoute) {
      String oldRouteName = state.currentRouteName;
      emit(state.copyWith(currentRouteName: routeName));
      emit(state.copyWith(currentRouteName: oldRouteName));
      return;
    }
    emit(state.copyWith(currentRouteName: routeName));
  }

  void handleNavigation(int index, StatefulNavigationShell navigationShell) {
    if (index != 0 && !state.isAuthenticated) {
      DNavigator.goNamed(RouteNamed.noAuth);
      setStopAllMedia(true);
      setStopAllMedia(false);
      return;
    }

    if (index == 2) {
      DNavigator.goNamed(RouteNamed.camera);
      setStopAllMedia(true);
      setStopAllMedia(false);
      return;
    }

    switch (index) {
      case 0:
        setCurrentRouteName(RouteNamed.home);
        break;
      case 1:
        setCurrentRouteName(RouteNamed.vnsShop);
        break;
      case 3:
        setCurrentRouteName(RouteNamed.notification);
        break;
      case 4:
        setCurrentRouteName(RouteNamed.profile);
        AppConfig.context!.read<UserCubit>().initProfilePage();
        break;
    }

    setCurrentIndex(index);
    navigationShell.goBranch(index);
  }

  void navigationFromService(Uri uri) {
    _resolveServiceLink(uri);
    if (_serviceRouteName == RouteNamed.shellRoute) {
      setCurrentRouteName(RouteNamed.home);
      return;
    }

    setCurrentRouteName(_serviceRouteName);
    if (!state.isAuthenticated) {
      _handleNoAuthRoute();
      return;
    }

    handleRoute();
  }

  void handleRoute() {
    _handleServiceRouteParam();
    _handleShellRoute();
    _handleNormalRoute();
    _resetServiceRouteData();
  }

  void _handleShellRoute() {
    switch (_serviceRouteName) {
      case RouteNamed.home:
        setCurrentIndex(0);
        break;
      case RouteNamed.vnsShop:
        setCurrentIndex(1);
        break;
      case RouteNamed.notification:
        setCurrentIndex(3);
        break;
      case RouteNamed.profile:
        setCurrentIndex(4);
        AppConfig.context!.read<UserCubit>().initProfilePage();
        break;
    }
  }

  void _handleNoAuthRoute() {
    switch (_serviceRouteName) {
      case RouteNamed.login:
        DNavigator.goNamed(RouteNamed.login);
        break;
      case RouteNamed.register:
        DNavigator.goNamed(RouteNamed.register);
        break;
      case RouteNamed.forgotPassword:
        DNavigator.goNamed(RouteNamed.forgotPassword);
        break;
      default:
        DNavigator.goNamed(RouteNamed.noAuth);
        break;
    }
  }

  void _handleNormalRoute() {
    switch (_serviceRouteName) {
      case RouteNamed.livestream:
        AppUser user = AppConfig.context!.read<UserCubit>().state.user;
        AppConfig.context!.read<LiveCubit>().getLiveDetail(
          onSuccess: (Live live) {
            if (live.status != LiveStatus.live) {
              DMessage.showMessage(message: AppConfig.context!.text.liveSessionUnavailable, type: MessageType.error);
              return;
            }
            AppConfig.context!.read<LiveSettingCubit>().generateLiveToken(
                  roomId: live.roomId,
                  onSuccess: () {
                    if (user.isHost && user.id == live.user.id) {
                      AppConfig.context?.pushNamed(RouteNamed.livestreamEmployee);
                      return;
                    }

                    AppConfig.context?.read<LiveCubit>().markAsRead();
                    AppConfig.context?.pushNamed(RouteNamed.livestream);
                  },
                );
          },
        );
        break;
      case RouteNamed.profilePreview:
        DNavigator.goNamed(RouteNamed.profilePreview);
        break;
      case RouteNamed.productDetail:
        DNavigator.goNamed(RouteNamed.productDetail);
        break;
      case RouteNamed.notification:
        DNavigator.goNamed(RouteNamed.notification);
        break;
    }
  }

  void _resetServiceRouteData() {
    _serviceRouteName = '';
    _serviceRouteQuery = {};
  }

  void _resolveServiceLink(Uri uri) {
    LogDev.one('ServiceRoute, uri: $uri');
    final String host = uri.host;
    final String path = uri.path;
    final String query = uri.query;
    final String fragment = uri.fragment;
    final Map<String, String> queryParameters = uri.queryParameters;
    _serviceRouteName = path.pathToCamelCase;
    _serviceRouteQuery = queryParameters;
    _handleServiceRouteParam();
    LogDev.one('ServiceRoute, pathValue: ${path.pathToCamelCase}, query: $query, host: $host, fragment: $fragment, queryParameters: $_serviceRouteQuery');
  }

  _handleServiceRouteParam() {
    if (!state.isAuthenticated) return;
    _handleServiceRouteProfile();
    _handleServiceRouteAffiliate();
    _handleServiceRouteProduct();
    _handleServiceRouteLiveStream();
  }

  void _handleServiceRouteProfile() {
    if (_serviceRouteQuery['id'] == null) return;
    final int id = _serviceRouteQuery['id']!.toInt;
    AppConfig.context!.read<ProfilePreviewCubit>()
      ..setCurrentUser(AppUser(id: id))
      ..initProfilePage();
  }

  void _handleServiceRouteAffiliate() {
    if (_serviceRouteQuery['affiliateId'] == null) return;
    final int affiliateId = _serviceRouteQuery['affiliateId']!.toInt;
    AppGlobalValue.affiliateId = affiliateId;
  }

  void _handleServiceRouteProduct() {
    if (_serviceRouteQuery['productId'] == null) return;
    final int productId = _serviceRouteQuery['productId']!.toInt;
    Product product = Product(id: productId);
    AppConfig.context!.read<ProductCubit>().initProductData(product);
  }

  void _handleServiceRouteLiveStream() {
    if (_serviceRouteQuery['liveId'] == null || _serviceRouteQuery['roomId'] == null || _serviceRouteQuery['hostId'] == null) return;
    final int id = _serviceRouteQuery['liveId']!.toInt;
    final String roomId = _serviceRouteQuery['roomId']!;
    final int userId = _serviceRouteQuery['hostId']!.toInt;
    final AppUser user = AppUser(id: userId);
    final Live live = Live(id: id, roomId: roomId, user: user);

    AppConfig.context!.read<LiveCubit>()
      ..setCurrentLive(live)
      ..getLiveBooth();
  }
}
