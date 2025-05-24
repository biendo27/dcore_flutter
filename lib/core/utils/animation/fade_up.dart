part of '../utils.dart';

class FadeUp extends StatefulWidget {
  final Widget child;
  const FadeUp({super.key, required this.child});

  @override
  State<FadeUp> createState() => _FadeUpState();
}

class _FadeUpState extends State<FadeUp> with SingleTickerProviderStateMixin {
  late Animation<double> marginTop = Tween<double>(begin: 30, end: 0).animate(animController)
    ..addListener(() {
      setState(() {});
    });
  late Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(animController)
    ..addListener(() {
      setState(() {});
    });
  late AnimationController animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  @override
  void initState() {
    animController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.value,
      child: Container(
        padding: EdgeInsets.only(top: marginTop.value),
        decoration: const BoxDecoration(),
        child: widget.child,
      ),
    );
  }
}
