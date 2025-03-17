part of '../utils.dart';

class DTitleAndText extends StatelessWidget {
  final String title;
  final String text;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextAlign titleAlign;
  final TextAlign textAlign;
  final EdgeInsets margin;
  final int titleMaxLines;
  final int textMaxLines;
  final int flexTitle;
  final int flexText;
  const DTitleAndText({
    super.key,
    required this.title,
    required this.text,
    this.titleStyle,
    this.textStyle,
    this.titleAlign = TextAlign.start,
    this.textAlign = TextAlign.end,
    this.margin = EdgeInsets.zero,
    this.titleMaxLines = 2,
    this.textMaxLines = 2,
    this.flexTitle = 4,
    this.flexText = 5,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmp =  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flexTitle,
            child: AppText(
              title,
              style: titleStyle ?? AppStyle.textBold16,
              textAlign: titleAlign,
              maxLines: titleMaxLines,
            ),
          ),
          Expanded(
            flex: flexText,
            child: AppText(
              text,
              style: textStyle ?? AppStyle.text14,
              textAlign: textAlign,
              maxLines: textMaxLines,
            ),
          ),
      ],
    );

    if (margin != EdgeInsets.zero) {
      tmp = Container(
        margin: margin.w,
        child: tmp,
      );
    }

    return tmp;
  }
}
