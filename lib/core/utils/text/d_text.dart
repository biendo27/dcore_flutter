part of '../utils.dart';

class AppText extends StatelessWidget {
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

  const AppText(
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
  })  : assert(maxLines > 0, 'maxLines must be greater than 0'),
        assert(expandFlex >= 0, 'expandFlex must be greater than or equal to 0'),
        assert(width >= 0, 'width must be greater than or equal to 0'),
        assert(!(expandFlex > 0 && width > 0), 'expandFlex and width cannot be used together'),
        assert(!(expandFlex > 0 && enableFitScaleDown), 'expandFlex and enableFitScaleDown cannot be used together');

  @override
  Widget build(BuildContext context) {
    Widget tmpText = Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: maxLines != 1,
      textScaler: TextScaler.linear(textScaleFactor),
      style: style ?? AppStyle.text14,
      textWidthBasis: textWidthBasis,
    );

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

    if (margin != EdgeInsets.zero) {
      tmpText = Container(
        margin: margin,
        child: tmpText,
      );
    }
    
    if (expandFlex > 0) {
      tmpText = Expanded(
        flex: expandFlex,
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

enum DTextType {
  headerLarge,
  headerMedium,
  headerSmall,
  titleLarge,
  titleMedium,
  // Subtitle
  titleSmall,
  textLarge,
  textDefault,
  textSmall,
  labelLarge,
  labelMedium,
  labelSmall;

  TextStyle get style {
    return switch (this) {
      DTextType.headerLarge => Theme.of(AppConfig.context!).textTheme.displayLarge!,
      DTextType.headerMedium => Theme.of(AppConfig.context!).textTheme.displayMedium!,
      DTextType.headerSmall => Theme.of(AppConfig.context!).textTheme.displaySmall!,
      DTextType.titleLarge => Theme.of(AppConfig.context!).textTheme.titleLarge!,
      DTextType.titleMedium => Theme.of(AppConfig.context!).textTheme.titleMedium!,
      DTextType.titleSmall => Theme.of(AppConfig.context!).textTheme.titleSmall!,
      DTextType.textLarge => Theme.of(AppConfig.context!).textTheme.bodyLarge!,
      DTextType.textDefault => Theme.of(AppConfig.context!).textTheme.bodyMedium!,
      DTextType.textSmall => Theme.of(AppConfig.context!).textTheme.bodySmall!,
      DTextType.labelLarge => Theme.of(AppConfig.context!).textTheme.labelLarge!,
      DTextType.labelMedium => Theme.of(AppConfig.context!).textTheme.labelMedium!,
      DTextType.labelSmall => Theme.of(AppConfig.context!).textTheme.labelSmall!,
    };
  }
}

enum TextFormat {
  title,
  titleAndText,
  iconText,
}

@Deprecated('Use DText instead')
class DText extends StatelessWidget {
  final String text;
  final String title;
  final DTextType textType;
  final DTextType titleType;
  final Color? color;
  final Color? titleColor;
  final Color? backgroundColor;
  final Widget? icon;
  final bool underline;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow textOverflow;
  final double? width;
  final double? fontSize;
  final double? titleSize;
  final FontWeight? fontWeight;
  final FontWeight? titleWeight;
  final TextFormat format;
  final TextDecoration? decoration;
  final double? decorationThickness;
  final VoidCallback? onTap;
  final bool enableExpanded;
  final int expandFlex;
  final bool enableMargin;
  final EdgeInsets? margin;
  final double? textTitleSpace;
  final double textScaleFactor;

  /// Default is [CrossAxisAlignment.start] for [TextFormat.titleAndText]
  final CrossAxisAlignment crossAxisAlignment;

  const DText({
    super.key,
    required this.text,
    this.title = '',
    this.textType = DTextType.textDefault,
    this.titleType = DTextType.textDefault,
    this.color,
    this.titleColor,
    this.backgroundColor,
    this.icon,
    this.underline = false,
    this.textAlign = TextAlign.center,
    this.maxLines = 1000,
    this.textOverflow = TextOverflow.ellipsis,
    this.width,
    this.fontSize,
    this.titleSize,
    this.fontWeight,
    this.titleWeight,
    this.format = TextFormat.title,
    this.decoration,
    this.decorationThickness,
    this.onTap,
    this.enableExpanded = false,
    this.expandFlex = 1,
    this.enableMargin = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.textTitleSpace,
    this.textScaleFactor = 1,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : assert(icon == null || format == TextFormat.iconText, 'Icon only use with format iconText');

  @override
  Widget build(BuildContext context) {
    Widget textTmp = Text(
      text,
      textAlign: format == TextFormat.titleAndText ? TextAlign.right : textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      softWrap: maxLines != 1,
      textScaler: TextScaler.linear(textScaleFactor),
      style: textType.style.copyWith(
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: color,
        decorationThickness: decorationThickness,
      ),
    );

    Widget result = textTmp;

    if (format == TextFormat.iconText) {
      result = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon!,
          const SizedBox(width: 3),
          Expanded(child: textTmp),
        ],
      );
    }

    if (format == TextFormat.titleAndText) {
      result = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          Text(
            title,
            style: titleType.style.copyWith(
              color: titleColor ?? color,
              fontSize: titleSize ?? fontSize,
              fontWeight: titleWeight ?? fontWeight ?? FontWeight.w500,
            ),
          ),
          SizedBox(width: textTitleSpace ?? 10),
          Expanded(child: textTmp),
        ],
      );
    }

    if (format == TextFormat.title && width != null) {
      result = SizedBox(
        width: width,
        child: textTmp,
      );
    }

    if (onTap != null) {
      result = GestureDetector(
        onTap: onTap,
        child: result,
      );
    }

    result = Tooltip(
      showDuration: const Duration(seconds: 1),
      message: text,
      child: result,
    );

    if (margin != null && enableMargin) {
      result = Container(
        margin: margin,
        child: result,
      );
    }

    if (enableExpanded) {
      result = Expanded(
        flex: expandFlex,
        child: result,
      );
    }

    return result;
  }
}
