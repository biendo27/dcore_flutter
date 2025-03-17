part of '../widgets.dart';

class SubLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget body;
  final String title;
  final Widget? customTitle;
  final bool isLoading;
  final bool canPop;
  final bool canBack;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final List<Widget> actions;
  final void Function()? onBackSuccess;
  final void Function(bool didPop, Object? result)? onPopInvokedWithResult;
  final void Function()? onLoadMore;
  final Future<void> Function()? onRefresh;
  final Color? appBarBackgroundColor;
  final Color? appBarSurfaceColor;
  final bool extendBodyBehindAppBar;
  final double? appBarElevation;
  final String backgroundImage;
  final bool enableAppBar;
  final Widget? endDrawer;
  final Widget? drawer;

  const SubLayout({
    super.key,
    this.scaffoldKey,
    required this.body,
    this.title = '',
    this.customTitle,
    this.isLoading = false,
    this.canPop = false,
    this.canBack = true,
    this.resizeToAvoidBottomInset = false,
    this.backgroundColor,
    this.actions = const [],
    this.onBackSuccess,
    this.onPopInvokedWithResult,
    this.onLoadMore,
    this.onRefresh,
    this.appBarBackgroundColor,
    this.appBarSurfaceColor,
    this.extendBodyBehindAppBar = false,
    this.appBarElevation,
    this.backgroundImage = '',
    this.enableAppBar = true,
    this.endDrawer,
    this.drawer,
  });

  ImageProvider get backgroundImageProvider {
    if (backgroundImage.startsWith('http://') || backgroundImage.startsWith('https://')) {
      return CachedNetworkImageProvider(backgroundImage);
    }

    if (backgroundImage.startsWith('/')) {
      return FileImage(File(backgroundImage));
    }

    return AssetImage(backgroundImage);
  }

  @override
  Widget build(BuildContext context) {
    Widget tmpLayout = Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: !enableAppBar
          ? null
          : AppBar(
              backgroundColor: appBarBackgroundColor,
              surfaceTintColor: appBarSurfaceColor,
              elevation: appBarElevation,
              leading: canBack
                  ? InkWell(
                      onTap: () {
                        DNavigator.back();
                        onBackSuccess?.call();
                      },
                      child: Icon(FontAwesomeIcons.arrowLeft, size: 24.sp),
                    )
                  : SizedBox.shrink(),
              title: customTitle ?? AppText(title, style: AppStyle.text18.copyWith(fontWeight: FontWeight.w600)),
              actions: actions,
            ),
      body: body,
      endDrawer: endDrawer,
      drawer: drawer,
    );

    if (onPopInvokedWithResult != null) {
      tmpLayout = PopScope(
        canPop: canPop,
        onPopInvokedWithResult: onPopInvokedWithResult,
        child: tmpLayout,
      );
    }

    if (isLoading) {
      tmpLayout = Stack(
        children: [
          tmpLayout,
          ModalBarrier(color: AppColorLight.onSurface.op(0.5)),
          const AppLoading(),
        ],
      );
    }

    if (backgroundImage.isNotEmpty) {
      tmpLayout = Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: backgroundImageProvider, fit: BoxFit.cover),
        ),
        child: tmpLayout,
      );
    }

    if (onRefresh != null) {
      tmpLayout = RefreshIndicator(onRefresh: onRefresh!, child: tmpLayout);
    }

    if (onLoadMore != null) {
      tmpLayout = NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is! ScrollEndNotification) return false;
          if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
          onLoadMore?.call();
          return true;
        },
        child: tmpLayout,
      );
    }

    return Unfocused(child: tmpLayout);
  }
}
