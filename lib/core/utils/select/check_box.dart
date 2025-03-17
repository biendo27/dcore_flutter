// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../utils.dart';

class DCheckBox extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?)? onChanged;
  final double space;
  final EdgeInsets margin;
  final TextStyle? style;

  const DCheckBox({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.space = 5,
    this.margin = EdgeInsets.zero,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged!(!value),
      child: Container(
        margin: margin,
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
              ),
            ),
            SizedBox(width: space.w),
            AppText(title, style: style ?? AppStyle.text16),
          ],
        ),
      ),
    );
  }
}
