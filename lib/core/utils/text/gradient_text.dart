
part of '../utils.dart';

class AppGradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final TextWidthBasis textWidthBasis;
  final bool enableTooltip;
  final void Function()? onTap;
  final int expandFlex;
  final EdgeInsets margin;
  final double width;
  final bool enableFitScaleDown;
  final Gradient gradient;

  const AppGradientText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1,
    this.maxLines = 1,
    this.textWidthBasis = TextWidthBasis.parent,
    this.enableTooltip = false,
    this.onTap,
    this.expandFlex = 0,
    this.margin = EdgeInsets.zero,
    this.width = 0,
    this.enableFitScaleDown = false,
    required this.gradient,
  })  : assert(maxLines > 0, 'maxLines must be greater than 0'),
        assert(expandFlex >= 0, 'expandFlex must be greater than or equal to 0'),
        assert(width >= 0, 'width must be greater than or equal to 0'),
        assert(!(expandFlex > 0 && width > 0), 'expandFlex and width cannot be used together'),
        assert(!(expandFlex > 0 && enableFitScaleDown), 'expandFlex and enableFitScaleDown cannot be used together');

  @override
  Widget build(BuildContext context) {
    Widget tmpText = ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: maxLines != 1,
        textScaler: TextScaler.linear(textScaleFactor),
        style: style ?? AppStyle.text14,
        textWidthBasis: textWidthBasis,
      ),
    );

    // ... rest of the build method remains the same as AppText
    if (enableTooltip) {
      tmpText = Tooltip(
        showDuration: const Duration(seconds: 1),
        message: text,
        child: tmpText,
      );
    }

    if (onTap != null) {
      tmpText = GestureDetector(
        onTap: onTap,
        child: tmpText,
      );
    }

    if (expandFlex > 0) {
      tmpText = Expanded(
        flex: expandFlex,
        child: tmpText,
      );
    }

    if (margin != EdgeInsets.zero) {
      tmpText = Container(
        margin: margin,
        child: tmpText,
      );
    }

    if (width > 0) {
      tmpText = SizedBox(
        width: width,
        child: tmpText,
      );
    }

    if (enableFitScaleDown) {
      tmpText = FittedBox(
        fit: BoxFit.scaleDown,
        child: tmpText,
      );
    }

    return tmpText;
  }
}
