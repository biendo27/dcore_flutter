part of '../utils.dart';

class GradientTabIndicator extends Decoration {
  final Gradient gradient;
  final double indicatorHeight;
  final BorderRadius borderRadius;

  const GradientTabIndicator({
    required this.gradient,
    this.indicatorHeight = 3.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientPainter(
      gradient: gradient,
      indicatorHeight: indicatorHeight,
      borderRadius: borderRadius,
      onChanged: onChanged,
    );
  }
}

class _GradientPainter extends BoxPainter {
  final Paint _paint = Paint();
  final double indicatorHeight;
  final Gradient gradient;
  final BorderRadius borderRadius;

  _GradientPainter({
    required this.gradient,
    required this.indicatorHeight,
    required this.borderRadius,
    VoidCallback? onChanged,
  }) : super(onChanged) {
    _paint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Rect indicator = Rect.fromLTWH(rect.left, rect.bottom - indicatorHeight, rect.width, indicatorHeight);
    
    // Create the gradient shader here, using the indicator's dimensions
    _paint.shader = gradient.createShader(indicator);
    
    // Use a path to draw a rounded rectangle
    final Path path = Path()
      ..addRRect(RRect.fromRectAndCorners(
        indicator,
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      ));
    
    canvas.drawPath(path, _paint);
  }
}
