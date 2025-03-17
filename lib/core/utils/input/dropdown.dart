part of '../utils.dart';

class DropdownItem<T> {
  final String label;
  final T value;
  DropdownItem({
    this.label = '',
    required this.value,
  });
}

class DDropDownButton<T> extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final List<DropdownItem> items;
  final T? selectedValue;
  final Function(T?)? onChanged;
  final Color? fillColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsets? contentPadding;
  final double? fontSize;
  final EdgeInsets margin;
  final double width;
  final int expandFlex;
  final bool requiredField;

  const DDropDownButton({
    super.key,
    this.label = '',
    this.hint = '',
    this.inputStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.items = const [],
    required this.selectedValue,
    required this.onChanged,
    this.fillColor,
    this.border,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.fontSize,
    this.margin = const EdgeInsets.only(bottom: 15),
    this.width = 0,
    this.expandFlex = 0,
    this.requiredField = false,
  })  : assert(width >= 0, 'Width must be greater than or equal to 0'),
        assert(expandFlex >= 0, 'ExpandFlex must be greater than or equal to 0'),
        assert(width == 0 || expandFlex == 0, 'width and expandFlex cannot be used together');

  List<DropdownMenuItem<T>> get _items {
    List<DropdownMenuItem<T>> tmpItems = [];
    tmpItems.addAll(
      items.map(
        (e) => DropdownMenuItem<T>(
          value: e.value,
          child: AppText(e.label, style: inputStyle),
        ),
      ),
    );
    return tmpItems;
  }

  String get _hint {
    if (hint.isEmpty) {
      return AppConfig.context!.text.selectOne;
    }

    return hint;
  }

  Widget? _label(InputDecorationTheme theme) {
    if (label.isEmpty) return null;
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: label,
        style: labelStyle ?? theme.labelStyle,
        children: [
          TextSpan(
            text: requiredField ? ' *' : '',
            style: theme.errorStyle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    InputDecorationTheme theme = context.watch<ThemeCubit>().state.themeUtil.inputDecorationTheme;

    Widget tmp = DropdownButtonFormField<T>(
      items: _items,
      onChanged: onChanged,
      value: selectedValue,
      style: inputStyle,
      icon: Icon(FontAwesomeIcons.chevronDown, size: 15.sp, color: AppTheme.outlineVariant),
      decoration: InputDecoration(
        alignLabelWithHint: theme.alignLabelWithHint,
        floatingLabelBehavior: theme.floatingLabelBehavior,
        floatingLabelAlignment: theme.floatingLabelAlignment,
        hintFadeDuration: theme.hintFadeDuration,
        isCollapsed: theme.isCollapsed,
        isDense: theme.isDense,
        contentPadding: contentPadding ?? theme.contentPadding,
        hintStyle: hintStyle ?? theme.hintStyle,
        labelStyle: labelStyle ?? theme.labelStyle,
        errorStyle: errorStyle ?? theme.errorStyle,
        hintText: _hint,
        filled: theme.filled,
        label: _label(theme),
        fillColor: fillColor ?? theme.fillColor,
        enabledBorder: enabledBorder ?? theme.enabledBorder,
        focusedBorder: focusedBorder ?? theme.focusedBorder,
        errorBorder: border ?? theme.errorBorder,
        border: border ?? theme.border,
        disabledBorder: disabledBorder ?? theme.disabledBorder,
        focusedErrorBorder: focusedErrorBorder ?? theme.focusedErrorBorder,
      ),
    );

    if (margin != EdgeInsets.zero) {
      tmp = Container(
        margin: margin.h,
        child: tmp,
      );
    }

    if (width > 0) {
      tmp = SizedBox(
        width: width.w,
        child: tmp,
      );
    }

    if (expandFlex > 0) {
      tmp = Expanded(
        flex: expandFlex,
        child: tmp,
      );
    }

    return tmp;
  }
}
