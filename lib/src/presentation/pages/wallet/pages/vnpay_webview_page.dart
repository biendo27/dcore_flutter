part of '../wallet.dart';

class VnpayWebViewPage extends StatefulWidget {
  final String url;
  const VnpayWebViewPage({super.key, required this.url});

  @override
  State<VnpayWebViewPage> createState() => _VnpayWebViewPageState();
}

class _VnpayWebViewPageState extends State<VnpayWebViewPage> {
  late final WebViewController _controller;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) => isLoadingNotifier.value = true,
          onPageFinished: (String url) {
            isLoadingNotifier.value = false;
            if (url.contains('vnp_ResponseCode=00') && url.contains('vnp_TransactionStatus=00')) {
              // Payment successful
              DMessage.showMessage(
                message: context.text.paymentSuccess,
                type: MessageType.success,
              );
              int pageIndex = context.read<PageCubit>().state.currentIndex;
              switch (pageIndex) {
                case 0:
                  DNavigator.newRoutesNamed(RouteNamed.home);
                  break;
                case 1:
                  DNavigator.replaceNamed(RouteNamed.paymentSuccess);
                  break;
                case 4:
                  DNavigator.newRoutesNamed(RouteNamed.profile);
                  break;
                default:
                  DNavigator.back();
                  break;
              }
              context.read<UserCubit>().getUser();
              return;
            }

            if (url.contains('vnp_ResponseCode')) {
              // Payment failed
              DMessage.showMessage(
                message: context.text.paymentFailed,
                type: MessageType.error,
              );
              DNavigator.back();
            }
          },
          onWebResourceError: (WebResourceError error) {
            DMessage.showMessage(
              message: '${context.text.errorOccurred}: ${error.description}',
              type: MessageType.error,
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLoadingNotifier,
        builder: (context, isLoading, child) {
          return SubLayout(
            title: context.text.vnpayPayment,
            isLoading: isLoading,
            body: WebViewWidget(controller: _controller),
          );
        });
  }
}
