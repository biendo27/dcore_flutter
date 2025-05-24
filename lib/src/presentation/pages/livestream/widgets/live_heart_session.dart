part of '../livestream.dart';

class LiveHeartSession extends StatelessWidget {
  const LiveHeartSession({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveHeartCubit, int>(
      builder: (context, state) {
        if (state < 1) return const SizedBox.shrink();

        return Stack(
          children: List.generate(state, (_) {
            return HeartAnimationWidget(
              onAnimationComplete: () => context.read<LiveHeartCubit>().removeHeart(),
            );
          }),
        );
      },
    );
  }
}

class HeartAnimationWidget extends StatelessWidget {
  final VoidCallback onAnimationComplete;

  static const Duration totalDuration = Duration(seconds: 2);

  static final Duration moveAndScaleDuration = Duration(milliseconds: 1600);
  static final Duration fadeDuration = Duration(milliseconds: 400);

  const HeartAnimationWidget({
    super.key,
    required this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    final child = Positioned(
      bottom: 50,
      right: 50,
      child: TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -200)),
        duration: const Duration(seconds: 2),
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: Opacity(
              opacity: 1 - (offset.dy / -200),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ),
            ),
          );
        },
      ),
    );

    return child
        .animate()
        .slide(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
          curve: Curves.easeOutCubic,
          duration: const Duration(seconds: 2),
        )
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          alignment: Alignment.bottomCenter,
          curve: Curves.easeOutExpo,
          duration: moveAndScaleDuration,
        )
        .then(delay: Duration.zero, duration: fadeDuration)
        .fadeOut(curve: Curves.easeOut)
        .callback(
          callback: (_) => onAnimationComplete(),
        );
  }
}
