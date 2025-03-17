part of '../utils.dart';

class SliverListChild extends StatelessWidget {
  final bool list;
  final bool fixedExtentList;
  final EdgeInsets? padding;

  final List<Widget> children;
  const SliverListChild({
    super.key,
    this.list = false,
    this.fixedExtentList = false,
    required this.children,
    this.padding,
  }) : assert(list || fixedExtentList);

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (list) {
      child = SliverList(
        delegate: SliverChildListDelegate(children),
      );
    }
    if (fixedExtentList) {
      child = SliverFixedExtentList(
        delegate: SliverChildListDelegate(children),
        itemExtent: 100,
      );
    }

    if (padding != null) {
      child = SliverPadding(
        padding: padding!,
        sliver: child!,
      );
    }

    return child!;
  }
}
