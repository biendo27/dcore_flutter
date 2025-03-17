part of '../utils.dart';

class LoadMore extends StatelessWidget {
  final void Function()? onLoadMore;
  final Future<void> Function()? onRefresh;
  final Widget child;

  const LoadMore({
    super.key,
    this.onLoadMore,
    this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmpLayout = child;
    
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

    return tmpLayout;
  }
}
