part of '../livestream.dart';

class LivestreamCommentItemBody extends StatelessWidget {
  final String content;

  const LivestreamCommentItemBody({
    super.key,
    this.content = '',
  });

  @override
  Widget build(BuildContext context) {
    if (content.containsHtmlTag) {
      return SizedBox(
        width: 0.6.sw,
        child: HtmlWidget(
          content,
          textStyle: AppStyle.text14.copyWith(color: AppColorLight.onPrimary, fontWeight: FontWeight.w500),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        TextSpan textSpan = TextSpan(text: content, style: AppStyle.text14.copyWith(color: AppColorLight.onPrimary, fontWeight: FontWeight.w500));
        TextPainter tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: 0.6.sw);
        int numberOfLines = tp.computeLineMetrics().length;


        if (numberOfLines < 2) {
          return AppText(
            content,
            style: AppStyle.text14.copyWith(color: AppColorLight.onPrimary, fontWeight: FontWeight.w500),
          );
        }

        return SizedBox(
          width: 0.6.sw,
          child: ExpandableText(
            content,
            expandText: context.text.seeMore,
            style: AppStyle.text14.copyWith(color: AppColorLight.onPrimary, fontWeight: FontWeight.w500),
            maxLines: 2,
          ),
        );
      },
    );
  }
}
