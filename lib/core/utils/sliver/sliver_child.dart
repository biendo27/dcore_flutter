part of '../utils.dart';

class SliverChild extends StatelessWidget {
  final bool toBoxAdapter;
  final EdgeInsets? padding;

  final Widget child;
  const SliverChild({
    super.key,
    this.toBoxAdapter = true,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;
    if (toBoxAdapter) {
      child = SliverToBoxAdapter(child: child);
    }

    if (padding != null) {
      child = SliverPadding(
        padding: padding!,
        sliver: child,
      );
    }

    return child;
  }
}
