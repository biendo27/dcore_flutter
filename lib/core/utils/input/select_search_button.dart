part of '../utils.dart';

class SelectSearchButton<T> extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final List<DropdownItem> items;
  final T? selectedValue;
  final void Function(T?)? onChanged;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsets? contentPadding;
  final double? fontSize;
  final EdgeInsets margin;
  final Color? color;
  final bool requiredField;

  const SelectSearchButton({
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
    this.borderColor,
    this.hintColor,
    this.border,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.fontSize,
    this.margin = EdgeInsets.zero,
    this.color,
    this.requiredField = false,
  });

  void _buildSearchDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    ValueNotifier<List<DropdownItem>> searchItemsNotifier = ValueNotifier(items);

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white,
          elevation: 0,
          actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 10).w,
          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 10).w,
          titlePadding: EdgeInsets.fromLTRB(10, 10, 10, 5).w,
          title: DTextField(
            controller: searchController,
            label: context.text.search,
            margin: EdgeInsets.zero,
            onChanged: (value) {
              if (value.isEmpty) {
                searchItemsNotifier.value = items;
                return;
              }

              List<DropdownItem<dynamic>> newValue = items.where((element) => element.label.toLowerCase().contains(value.toLowerCase())).toList();
              searchItemsNotifier.value = newValue;
            },
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ValueListenableBuilder(
                valueListenable: searchItemsNotifier,
                builder: (context, searchItems, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onChanged?.call(searchItems[index].value);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: AppText(
                            searchItems[index].label,
                            style: AppStyle.text16,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        );
      },
    );
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

  String get _value {
    return items.firstWhereOrDefault((element) => element.value == selectedValue)?.label ?? '';
  }

  @override
  Widget build(BuildContext context) {
    InputDecorationTheme theme = context.watch<ThemeCubit>().state.themeUtil.inputDecorationTheme;

    Widget child = InkWell(
      onTap: () => _buildSearchDialog(context),
      child: InputDecorator(
        decoration: InputDecoration(
          suffixIcon: Icon(FontAwesomeIcons.chevronDown, size: 15.sp, color: AppTheme.outlineVariant),
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
          label: _label(theme),
          filled: theme.filled,
          fillColor: fillColor,
          enabledBorder: enabledBorder ?? theme.enabledBorder,
          focusedBorder: focusedBorder ?? theme.focusedBorder,
          errorBorder: border ?? theme.errorBorder,
          border: border ?? theme.border,
          disabledBorder: disabledBorder ?? theme.disabledBorder,
          focusedErrorBorder: focusedErrorBorder ?? theme.focusedErrorBorder,
        ),
        child: _value.isEmpty
            ? AppText(
                _hint,
                style: inputStyle ?? theme.hintStyle,
              )
            : AppText(
                _value,
                style: inputStyle ?? AppStyle.text16,
              ),
      ),
    );

    if (margin != EdgeInsets.zero) {
      child = Container(
        margin: margin,
        child: child,
      );
    }

    return child;
  }
}
