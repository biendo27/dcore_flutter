part of '../utils.dart';

class Unfocused extends StatelessWidget {
  final Widget? child;
  const Unfocused({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
