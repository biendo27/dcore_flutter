part of '../utils.dart';

enum IconPosition {
  start,
  end,
}

class DIconText extends StatelessWidget {
  final Widget icon;
  final String text;
  final IconPosition iconPosition;
  final TextStyle? textStyle;
  final EdgeInsets margin;
  final double spacing;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double textScaleFactor;
  final bool enableTooltip;
  final int maxLines;
  final bool enableFitScaleDown;
  final TextWidthBasis textWidthBasis;
  final int expandFlex;
  final double width;
  final PlaceholderAlignment iconPlaceholderAlignment;
  final void Function()? onTap;

  const DIconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconPosition = IconPosition.start,
    this.textStyle,
    this.margin = EdgeInsets.zero,
    this.spacing = 8.0, // Spacing between icon and text
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1,
    this.enableTooltip = false,
    this.maxLines = 1,
    this.enableFitScaleDown = false,
    this.textWidthBasis = TextWidthBasis.parent,
    this.expandFlex = 0,
    this.width = 0.0,
    this.iconPlaceholderAlignment = PlaceholderAlignment.middle,
    this.onTap,
  })  : assert(maxLines > 0, 'maxLines must be greater than 0'),
        assert(expandFlex >= 0, 'expandFlex must be greater than or equal to 0'),
        assert(width >= 0, 'width must be greater than or equal to 0'),
        assert(!(expandFlex > 0 && width > 0), 'expandFlex and width cannot be used together'),
        assert(!(expandFlex > 0 && enableFitScaleDown), 'expandFlex and enableFitScaleDown cannot be used together');

  @override
  Widget build(BuildContext context) {
    // Create the text span
    final iconSpan = WidgetSpan(child: icon, alignment: iconPlaceholderAlignment);
    final spaceSpan = WidgetSpan(child: spacing.horizontalSpace);
    final textSpan = TextSpan(text: text);

    // Layout: Icon before or after the text, depending on IconPosition
    List<InlineSpan> children;

    if (iconPosition == IconPosition.start) {
      children = [iconSpan, spaceSpan, textSpan];
    } else {
      children = [textSpan, spaceSpan, iconSpan];
    }

    Widget tmpWidget = RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaler: TextScaler.linear(textScaleFactor),
      textWidthBasis: textWidthBasis,
      softWrap: maxLines != 1,
      text: TextSpan(
        style: textStyle ?? AppStyle.text14,
        children: children,
      ),
    );

    // Wrap with GestureDetector if onTap is provided
    if (onTap != null) {
      tmpWidget = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: tmpWidget,
      );
    }

    if (margin != EdgeInsets.zero) {
      tmpWidget = Container(
        margin: margin,
        child: tmpWidget,
      );
    }

    if (enableTooltip) {
      tmpWidget = Tooltip(
        message: text,
        child: tmpWidget,
      );
    }

    if (expandFlex > 0) {
      tmpWidget = Expanded(
        flex: expandFlex,
        child: tmpWidget,
      );
    }

    if (width > 0) {
      tmpWidget = SizedBox(
        width: width,
        child: tmpWidget,
      );
    }

    if (enableFitScaleDown) {
      tmpWidget = FittedBox(
        fit: BoxFit.scaleDown,
        child: tmpWidget,
      );
    }

    return tmpWidget;
  }
}
