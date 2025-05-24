part of '../utils.dart';

enum DButtonType {
  fill,
  outline,
  text,
}

class DButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Size? size;
  final TextStyle? style;
  final int expandedFlex;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final Color? textColor;
  final BorderSide? borderSide;
  final DButtonType buttonType;
  final double? elevation;
  final OutlinedBorder? shape;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget? customChild;
  final MaterialTapTargetSize? tapTargetSize;
  final VisualDensity? visualDensity;
  final Alignment? alignment;

  const DButton({
    super.key,
    this.text = 'Button',
    required this.onPressed,
    this.size,
    this.style,
    this.expandedFlex = 0,
    this.backgroundColor,
    this.surfaceTintColor,
    this.borderSide,
    this.buttonType = DButtonType.fill,
    this.elevation,
    this.shape,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = EdgeInsets.zero,
    this.tapTargetSize,
    this.visualDensity,
    this.alignment,
    this.customChild,
  }) : assert(borderSide == null || buttonType == DButtonType.outline, 'borderSideColor can only be used with DButtonType.secondary');

  Widget get btnWidget {
    Map<DButtonType, Widget> buttonTypeMap = {
      DButtonType.fill: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          iconAlignment: IconAlignment.start,
          tapTargetSize: tapTargetSize,
          visualDensity: visualDensity,
          alignment: alignment,
          padding: padding.w,
          backgroundColor: backgroundColor,
          surfaceTintColor: surfaceTintColor,
          elevation: elevation,
          shape: shape,
          minimumSize: size ?? Size.fromHeight(50.h),
        ),
        child: customChild ?? AppText(text, style: style ?? AppStyle.textBold16.copyWith(color: textColor ?? AppColorLight.surface)),
      ),
      DButtonType.outline: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          tapTargetSize: tapTargetSize,
          visualDensity: visualDensity,
          alignment: alignment,
          padding: padding.w,
          backgroundColor: backgroundColor,
          surfaceTintColor: surfaceTintColor,
          elevation: elevation,
          shape: shape,
          side: borderSide,
          minimumSize: size ?? Size.fromHeight(50.h),
        ),
        child: customChild ?? AppText(text, style: style ?? AppStyle.textBold16.copyWith(color: textColor ?? AppColorLight.surface)),
      ),
      DButtonType.text: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          tapTargetSize: tapTargetSize,
          visualDensity: visualDensity,
          alignment: alignment,
          padding: padding.w,
          backgroundColor: backgroundColor,
          surfaceTintColor: surfaceTintColor,
          elevation: elevation,
          shape: shape,
          minimumSize: size ?? Size.fromHeight(50.h),
        ),
        child: customChild ?? AppText(text, style: style ?? AppStyle.textBold16.copyWith(color: textColor ?? AppColorLight.surface)),
      ),
    };

    return buttonTypeMap[buttonType]!;
  }

  @override
  Widget build(BuildContext context) {
    Widget tmp = btnWidget;

    if (expandedFlex > 0) tmp = Expanded(flex: expandedFlex, child: tmp);

    if (margin != EdgeInsets.zero) tmp = Container(margin: margin, child: tmp);

    return tmp;
  }
}
