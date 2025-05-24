// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../utils.dart';

class PageTransition extends CustomTransitionPage {
  PageTransition({
    required super.child,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? customTransitionsBuilder,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.reverseTransitionDuration = const Duration(milliseconds: 300),
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.opaque = true,
    super.barrierDismissible = false,
    super.barrierColor,
    super.barrierLabel,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(
          transitionsBuilder: customTransitionsBuilder ??
              (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child);
              },
        );
}
