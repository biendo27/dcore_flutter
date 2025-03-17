part of '../widgets.dart';

class AuthLayout extends StatelessWidget {
  final Widget body;
  final bool isLoading;
  const AuthLayout({
    super.key,
    required this.body,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmpLayout = Scaffold(
      body: body,
    );

    if (isLoading) {
      tmpLayout = Stack(
        children: [
          tmpLayout,
          ModalBarrier(color: AppColorLight.onSurface.op(0.5)),
          const AppLoading(),
        ],
      );
    }

    return Unfocused(
      child: tmpLayout,
    );
  }
}
