part of '../../livestream.dart';

class LivestreamWhellWebViewPage extends StatefulWidget {
  final String url;
  const LivestreamWhellWebViewPage({
    super.key,
    this.url = '',
  });

  @override
  State<LivestreamWhellWebViewPage> createState() => _LivestreamWhellWebViewPageState();
}

class _LivestreamWhellWebViewPageState extends State<LivestreamWhellWebViewPage> {
  late final WebViewController _controller;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    if (widget.url.isEmpty) {
      debugPrint("URL is empty. Cannot load WebView.");
      return;
    }

    debugPrint('Access to whell webview: ${widget.url}');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Cho phép JavaScript
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoadingNotifier.value = true;
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            isLoadingNotifier.value = false;
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // Bắt đầu tải URL
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoadingNotifier,
      builder: (context, isLoading, child) {
        return Stack(
          alignment: Alignment.topLeft,
          children: [
            SubLayout(
              enableAppBar: false,
              title: context.text.luckySpinWheel,
              isLoading: isLoading,
              body: WebViewWidget(controller: _controller),
            ),
            InkWell(
              onTap: () {
                DNavigator.back();
                // onBackSuccess?.call();
              },
              child: Container(
                margin: EdgeInsets.only(top: 90, left: 20),
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 24.sp,
                  color: Colors.white,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
