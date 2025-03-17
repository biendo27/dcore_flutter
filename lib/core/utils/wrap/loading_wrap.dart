part of '../utils.dart';

class LoadingWrap extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingWrap({
    super.key,
    this.isLoading = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmpLayout = child;
    if (isLoading) {
      tmpLayout = Stack(
        children: [
          tmpLayout,
          ModalBarrier(color: AppColorLight.onSurface.op(0.5)),
          const AppLoading(),
        ],
      );
    }
    return tmpLayout;
  }
}
