part of '../utils.dart';

class SliverHeader extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  const SliverHeader({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.actions,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true,
      pinned: true,
      toolbarHeight: 152,
      centerTitle: true,
      // floating: false,
      title: title,
      actions: actions,
      expandedHeight: 400,
      flexibleSpace: flexibleSpace,
    );
  }
}
