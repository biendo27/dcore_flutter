part of '../widgets.dart';

class SearchTextfield extends StatelessWidget {
  final TextEditingController controller;
  final int expandFlex;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final dynamic Function(Object?)? onSubmit;
  final EdgeInsets margin;

  const SearchTextfield({
    super.key,
    required this.controller,
    this.expandFlex = 0,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onSubmit,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return DTextField(
      expandFlex: expandFlex,
      controller: controller,
      readOnly: readOnly,
      isDense: true,
      type: DTextInputType.search,
      onSubmit: (value) {
        if (onSubmit == null) return;
        onSubmit?.call(value);
      },
      prefix: Icon(Icons.search, size: 25.sp, color: AppColorLight.scrim),
      //  suffix: !kDebugMode ? null : Icon(FontAwesomeIcons.microphone, size: 20.sp, color: AppColorLight.scrim),
      hint: "${context.text.search}...",
      fillColor: const Color.fromRGBO(242, 242, 242, 1),
      margin: margin,
      // contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
