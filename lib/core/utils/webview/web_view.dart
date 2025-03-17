part of '../utils.dart';

// class WebView extends StatefulWidget {
//   const WebView({super.key});

//   @override
//   State<WebView> createState() => _WebViewState();
// }

// class _WebViewState extends State<WebView> {
//   final GlobalKey webViewKey = GlobalKey();

//   InAppWebViewController? webViewController;
//   InAppWebViewSettings settings = InAppWebViewSettings(
//     useShouldOverrideUrlLoading: true,
//     mediaPlaybackRequiresUserGesture: false,
//     // allowsInlineMediaPlayback: true,
//     // iframeAllow: "camera; microphone",
//     // iframeAllowFullscreen: true
//   );

//   PullToRefreshController? pullToRefreshController;
//   String url = '';
//   double progress = 0;
//   final urlController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     url = '';
//     pullToRefreshController = PullToRefreshController(
//       settings: PullToRefreshSettings(
//         color: Colors.blue,
//       ),
//       onRefresh: () async {
//         if (Platform.isAndroid) {
//           webViewController?.reload();
//         } else if (Platform.isIOS) {
//           webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black),
//       backgroundColor: Colors.black,
//       extendBodyBehindAppBar: true,
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: WebUri(url)),
//       ),
//     );
//   }
// }
