part of '../utils.dart';

class GradientButton extends DButton {
  final Gradient? gradient;

  const GradientButton({
    super.key,
    required super.onPressed,
    super.text = 'Gradient Button',
    super.size,
    super.style,
    super.expandedFlex = 0,
    this.gradient,
    super.borderSide,
    super.buttonType = DButtonType.fill,
    super.elevation,
    super.shape,
    super.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    super.margin = EdgeInsets.zero,
    super.tapTargetSize,
    super.visualDensity,
    super.alignment,
    super.customChild,
  });

  @override
  Widget get btnWidget {
    Map<DButtonType, Widget Function()> buttonTypeMap = {
      DButtonType.fill: () => _buildGradientFilledButton,
      DButtonType.outline: () => _buildGradientOutlinedButton,
      DButtonType.text: () => _buildGradientTextButton,
    };

    return buttonTypeMap[buttonType]!();
  }

  BorderRadius? get borderRadius {
    if (shape is RoundedRectangleBorder) {
      return (shape as RoundedRectangleBorder).borderRadius as BorderRadius;
    }
    // Provide a default border radius if not set
    return BorderRadius.circular(25.sp);
  }

  // Build Filled Button with gradient background
  Widget get _buildGradientFilledButton {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? LinearGradient(colors: AppCustomColor.gradientButton),
        borderRadius: borderRadius,
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          tapTargetSize: tapTargetSize,
          visualDensity: visualDensity,
          alignment: alignment,
          padding: padding.w,
          elevation: elevation,
          shape: shape,
          minimumSize: size ?? Size.fromHeight(50.h),
          backgroundColor: Colors.transparent, // Transparent to use gradient
        ),
        child: customChild ??
            AppText(
              text,
              style: style ?? AppStyle.textBold16.copyWith(color: AppColorLight.onPrimary),
            ),
      ),
    );
  }

  // Build Outlined Button with gradient applied to the border and text
  Widget get _buildGradientOutlinedButton {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: GradientBoxBorder(gradient: gradient ?? LinearGradient(colors: AppCustomColor.gradientButton)),
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          tapTargetSize: tapTargetSize,
          visualDensity: visualDensity,
          alignment: alignment,
          padding: padding.w,
          side: BorderSide(width: 0, color: Colors.transparent), // Transparent to allow gradient
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(25.sp),
              ),
          elevation: elevation,
          minimumSize: size ?? Size.fromHeight(50.h),
          backgroundColor: Colors.transparent, // Transparent to use gradient
        ),
        onPressed: onPressed,
        child: customChild ?? AppText(text, style: style ?? AppStyle.textBold16),
      ),
    );
  }

  // Build Text Button with gradient applied to the text only
  Widget get _buildGradientTextButton {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: tapTargetSize,
        visualDensity: visualDensity,
        alignment: alignment,
        padding: padding.w,
        shape: shape,
        minimumSize: size ?? Size.fromHeight(50.h),
        backgroundColor: Colors.transparent,
      ),
      child: GradientTypography(
        gradient: gradient ?? LinearGradient(colors: AppCustomColor.gradientButton),
        child: customChild ?? AppText(text, style: style ?? AppStyle.textBold16),
      ),
    );
  }
}
