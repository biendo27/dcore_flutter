// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../utils.dart';

class DRadioButton<T> extends StatelessWidget {
  final String title;
  final Object value;
  final Function(T?) onChanged;
  final T groupValue;
  final EdgeInsets margin;
  final double space;
  final TextStyle? style;
  const DRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    this.margin = EdgeInsets.zero,
    this.space = 5,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value as T),
      child: Container(
        margin: margin,
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Radio<T>(
                value: value as T,
                groupValue: groupValue,
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
