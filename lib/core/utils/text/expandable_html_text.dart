part of '../utils.dart';

/// A widget that displays HTML text which can be expanded or collapsed.
/// If the text exceeds [maxLines], a toggle ("View More"/"View Less") is shown with icons.
class ExpandableHtmlText extends StatefulWidget {
  const ExpandableHtmlText({
    super.key,
    required this.htmlText,
    this.maxLines = 5,
    this.textStyle,
    this.toggleTextStyle,
    this.padding,
    this.expandText = 'View More',
    this.collapseText = 'View Less',
    this.animationDuration = const Duration(milliseconds: 200),
    this.htmlStyle,
    this.gravity = TextAlign.start,
  });

  /// The HTML content to display.
  final String htmlText;

  /// The maximum number of lines to display when collapsed.
  final int maxLines;

  /// The style of the main text.
  final TextStyle? textStyle;

  /// The style of the toggle text.
  final TextStyle? toggleTextStyle;

  /// Padding around the widget.
  final EdgeInsets? padding;

  /// Text displayed when the content is collapsed.
  final String expandText;

  /// Text displayed when the content is expanded.
  final String collapseText;

  /// Duration of the expand/collapse animation.
  final Duration animationDuration;

  /// Additional styling for the HTML content.
  final TextStyle? htmlStyle;

  /// Alignment of the text.
  final TextAlign gravity;

  @override
  State<ExpandableHtmlText> createState() => _ExpandableHtmlTextState();
}

class _ExpandableHtmlTextState extends State<ExpandableHtmlText> with SingleTickerProviderStateMixin {
  /// Tracks whether the text is expanded.
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  /// Determines if the text exceeds [maxLines].
  final ValueNotifier<bool> _isOverflow = ValueNotifier<bool>(false);

  /// Estimated height per line based on font size.
  double get _lineHeight => widget.textStyle?.fontSize != null
      ? widget.textStyle!.fontSize! * 1.2 // Approximate line height
      : 14.0 * 1.2;

  @override
  void initState() {
    super.initState();
    // Check if the text exceeds [maxLines] after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  @override
  void dispose() {
    // Dispose the ValueNotifiers to free resources.
    _isExpanded.dispose();
    _isOverflow.dispose();
    super.dispose();
  }

  /// Checks if the text exceeds the maximum number of lines.
  void _checkOverflow() {
    // Strip HTML tags to get plain text
    final plainText = _stripHtml(widget.htmlText);

    // Define the TextSpan with the desired style
    final textSpan = TextSpan(
      text: plainText,
      style: widget.textStyle ?? DefaultTextStyle.of(context).style,
    );

    // Calculate the maximum width available for the text
    final maxWidth = MediaQuery.of(context).size.width - (widget.padding?.horizontal ?? 20.0); // Default padding: 10.0 * 2

    // Use TextPainter to determine if the text exceeds [maxLines]
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
      ellipsis: '...',
    );

    textPainter.layout(minWidth: 0, maxWidth: maxWidth);

    // Update _isOverflow based on whether the text exceeds [maxLines]
    _isOverflow.value = textPainter.didExceedMaxLines;
  }

  /// Toggles the expanded/collapsed state.
  void _toggleExpanded() {
    _isExpanded.value = !_isExpanded.value;
  }

  /// Strips HTML tags from the input string.
  String _stripHtml(String htmlText) {
    final document = parse(htmlText);
    return parse(document.body?.text).documentElement?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HTML Content with animated size transition
          ValueListenableBuilder<bool>(
            valueListenable: _isExpanded,
            builder: (context, isExpanded, child) {
              // Calculate the height based on the expanded/collapsed state
              final double contentHeight = isExpanded ? double.infinity : _lineHeight * widget.maxLines;

              return AnimatedContainer(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                constraints: isExpanded ? const BoxConstraints() : BoxConstraints(maxHeight: contentHeight),
                child: SingleChildScrollView(
                  physics: isExpanded ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
                  child: HtmlWidget(
                    widget.htmlText,
                    textStyle: widget.textStyle,
                    onTapUrl: (url) {
                      // Handle link taps if necessary
                      // For example, use url_launcher to open links
                      return true;
                    },
                  ),
                ),
              );
            },
          ),
          8.verticalSpace,
          // Toggle Text ("View More"/"View Less") with Icon if overflow exists
          ValueListenableBuilder<bool>(
            valueListenable: _isOverflow,
            builder: (context, isOverflow, child) {
              if (!isOverflow) return const SizedBox.shrink(); // No toggle if no overflow
              return ValueListenableBuilder<bool>(
                valueListenable: _isExpanded,
                builder: (context, isExpanded, child) {
                  return GestureDetector(
                    onTap: _toggleExpanded,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isExpanded ? widget.collapseText : widget.expandText,
                          style: widget.toggleTextStyle ??
                              const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                        ),
                        const SizedBox(width: 4.0),
                        Icon(
                          isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                          color: widget.toggleTextStyle?.color ?? Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
