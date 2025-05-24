part of '../home.dart';

class HeartAnimation extends StatefulWidget {
  const HeartAnimation({super.key});

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: 1.0 - _animation.value,
          child: Transform.translate(
            offset: Offset(0, -50 * _animation.value),
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 48,
            ),
          ),
        );
      },
    );
  }
}
