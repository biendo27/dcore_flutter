part of '../utils.dart';

class DHighlightText extends StatelessWidget {
  final String text;
  final List<String> highlights;
  final List<TextStyle>? highlightStyles; // Styles for highlighted parts
  final TextStyle? style; // Style for non-highlighted text
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;
  final double textScaleFactor;
  final TextWidthBasis textWidthBasis;
  final int expandFlex;

  const DHighlightText({
    super.key,
    required this.text,
    required this.highlights,
    this.highlightStyles,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textWidthBasis = TextWidthBasis.parent,
    this.expandFlex = 0,
  }) : assert(highlightStyles == null || highlightStyles.length == highlights.length, 'Highlight styles should either be null or have the same length as highlights');

  TextStyle get defaultStyle {
    return style ?? AppStyle.text14;
  }

  @override
  Widget build(BuildContext context) {
    Widget text = RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: maxLines != 1,
      textWidthBasis: textWidthBasis,
      text: TextSpan(
        children: _buildTextSpans(),
        style: defaultStyle, // Fallback for non-highlighted text
      ),
      textScaler: TextScaler.linear(textScaleFactor),
    );

    if (expandFlex > 0) {
      text = Expanded(
        flex: expandFlex,
        child: text,
      );
    }

    return text;
  }

  List<TextSpan> _buildTextSpans() {
    final List<TextSpan> spans = [];
    int lastEnd = 0;

    for (int i = 0; i < highlights.length; i++) {
      final highlight = highlights[i];
      final TextStyle highlightStyle = highlightStyles != null ? highlightStyles![i] : defaultStyle;

      // Find where the highlight appears in the main text
      final start = text.indexOf(highlight, lastEnd);

      if (start == -1) {
        // If the highlight is not found, continue
        continue;
      }

      // Add the non-highlighted text before the highlight
      if (start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, start),
          style: style,
        ));
      }

      // Add the highlighted text
      spans.add(TextSpan(
        text: highlight,
        style: highlightStyle,
      ));

      lastEnd = start + highlight.length;
    }

    // Add the remaining part of the text (if any)
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: style,
      ));
    }

    return spans;
  }
}
