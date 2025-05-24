part of '../utils.dart';

class LandingLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState>? globalKey;
  final List<Widget> body;
  final bool enableAction;
  final Future<void> Function()? onRefresh;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? floatingActionButton;
  final String title;
  final String subTitle;
  final VoidCallback? onBack;
  const LandingLayout({
    super.key,
    this.globalKey,
    required this.body,
    this.enableAction = false,
    this.onRefresh,
    this.contentPadding,
    this.floatingActionButton,
    this.title = '',
    this.subTitle = '',
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmp = Unfocused(
      child: Scaffold(
        appBar: _buildPrimayAppBar(context),
        key: globalKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        floatingActionButton: floatingActionButton,
        body: _buildBody(),
      ),
    );

    return tmp;
  }

  PopScope _buildBody() {
    return PopScope(
      onPopInvokedWithResult: _onWillPop,
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: SingleChildScrollView(
          padding: contentPadding ?? const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // DText(text: title, fontSize: 24, fontWeight: FontWeight.bold),
              // const SizedBox(height: 12),
              // DText(text: subTitle, fontSize: 16, textAlign: TextAlign.center),
              // const SizedBox(height: 40),
              ...body,
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildPrimayAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: onBack ?? () => context.back(),
        child: const Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.black, size: 16),
      ),
    );
  }

  void _onWillPop(bool isPop, dynamic result) {
    debugPrint('Back pressed');
    // DateTime now = DateTime.now();
    // if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   DMessage.showMessage(message: 'Ấn back lần nữa để thoát', type: MessageType.info);
    //   return;
    // }
  }
}
