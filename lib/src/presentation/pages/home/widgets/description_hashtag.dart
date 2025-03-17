part of '../home.dart';

class DescriptionHashtagWidget extends StatefulWidget {
  final String description;
  final String hashtags;

  const DescriptionHashtagWidget({
    super.key,
    required this.description,
    required this.hashtags,
  });

  @override
  State<DescriptionHashtagWidget> createState() => _DescriptionHashtagWidgetState();
}

class _DescriptionHashtagWidgetState extends State<DescriptionHashtagWidget> {
  bool isExpanded = false;
  final int maxLines = 2;

  @override
  Widget build(BuildContext context) {
    String description = widget.description;
    String hashtags = widget.hashtags;

    return LayoutBuilder(
      builder: (context, constraints) {
        TextSpan textSpan = TextSpan(
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
          children: [
            TextSpan(text: '$description '),
            TextSpan(
              text: hashtags,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );

        TextPainter textPainter = TextPainter(
          text: textSpan,
          maxLines: maxLines,
          textDirection: TextDirection.ltr,
          ellipsis: '...',
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        bool isOverflow = textPainter.didExceedMaxLines;

        if (!isOverflow && !isExpanded) {
          return RichText(
            text: textSpan,
          );
        }

        TextSpan link = TextSpan(
          text: isExpanded ? '  ${context.text.readLess}' : '  ${context.text.readMore}', 
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
        );

        if (isExpanded) {
          return RichText(
            text: TextSpan(
              children: [
                textSpan,
                link,
              ],
            ),
          );
        } else {
          String truncatedText = '$description $hashtags';
          int endIndex = truncatedText.length;

          while (endIndex > 0) {
            TextSpan testSpan = TextSpan(
              children: [
                TextSpan(text: truncatedText.substring(0, endIndex)),
                TextSpan(text: '...'),
                link,
              ],
            );

            TextPainter tp = TextPainter(
              text: testSpan,
              maxLines: maxLines,
              textDirection: TextDirection.ltr,
            );

            tp.layout(maxWidth: constraints.maxWidth);

            if (!tp.didExceedMaxLines) {
              break;
            }

            endIndex--;
          }

          truncatedText = truncatedText.substring(0, endIndex);

          return RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$truncatedText...'),
                link,
              ],
            ),
            maxLines: maxLines,
            overflow: TextOverflow.clip,
          );
        }
      },
    );
  }
}
