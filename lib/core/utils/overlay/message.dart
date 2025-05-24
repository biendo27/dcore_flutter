part of '../utils.dart';

class OverlayMessage extends StatefulWidget {
  final String message;
  final Widget? messageWidget;
  final MessageType type;
  final Duration duration;
  final SnackBarAction? action;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final DismissDirection? dismissDirection;
  final VoidCallback? onVisible;
  final VoidCallback? onTap;
  final ShapeBorder shape;
  final bool showCloseIcon;
  final Color? closeIconColor;
  final double? width;
  final AlignmentGeometry messageAlignment;
  final double leadingSpace;

  OverlayMessage({
    super.key,
    this.message = '',
    this.messageWidget,
    this.type = MessageType.danger,
    this.duration = const Duration(seconds: 3),
    this.action,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    this.elevation = 1.5,
    this.dismissDirection,
    this.onVisible,
    this.onTap,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    this.showCloseIcon = false,
    this.closeIconColor,
    this.width,
    this.messageAlignment = Alignment.topCenter,
    this.leadingSpace = 8,
  }) : assert(message.isNotEmpty || messageWidget != null, 'Message or messageWidget must not be null or empty');

  @override
  State<OverlayMessage> createState() => _OverlayMessageState();
}

class _OverlayMessageState extends State<OverlayMessage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const Curve curve = Curves.easeInOutCirc;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _playAnimation();
  }

  Offset _getTransformOffset() {
    final double animationValue = curve.transform(_controller.value);
    return switch (widget.messageAlignment) {
      Alignment.topCenter => Offset(0, -(1 - animationValue)),
      Alignment.bottomCenter => Offset(0, 1 - animationValue),
      _ => const Offset(0, 0),
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return FractionalTranslation(
          translation: _getTransformOffset(),
          child: child,
        );
      },
      animation: _controller,
      child: Align(
        alignment: widget.messageAlignment,
        child: InkWell(
          onTap: widget.onTap,
          child: Card(
            margin: widget.margin,
            shadowColor: widget.type.color,
            elevation: widget.elevation,
            shape: widget.shape,
            child: Padding(
              padding: widget.padding,
              child: Row(
                children: [
                  // Icon(widget.type.icon, color: widget.type.color, size: 20),
                  ...widget.messageWidget != null
                      ? [widget.messageWidget!]
                      : [
                          SvgPicture.asset(
                            widget.type.svgIcon,
                            colorFilter: ColorFilter.mode(widget.type.color, BlendMode.srcIn),
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: widget.leadingSpace),
                          AppText(
                            widget.message,
                            style: AppStyle.text12.copyWith(color: widget.type.color),
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            expandFlex: 1,
                          ),
                          if (widget.showCloseIcon)
                            IconButton(
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                              style: ButtonStyle(
                                minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                                padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                              ),
                              icon: Icon(
                                Icons.close,
                                color: widget.closeIconColor ?? Colors.grey,
                              ),
                              onPressed: () {
                                _controller.reverse(from: 1);
                              },
                            ),
                        ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() async {
    // fist will show banner with forward.
    if (!mounted) return;
    await _controller.forward();
    // wait for a time (3 second default) and then play reverse animation to hide the banner
    // Duration can be passed as parameter, banner will wait this much and then will dismiss
    await Future<void>.delayed(widget.duration);

    if (!mounted) return;
    await _controller.reverse(from: 1);
    // call onDismissedCallback so OverlayWidget can remove and clear the OverlayEntry.
    DOverlay.removeOverlay();
  }
}
