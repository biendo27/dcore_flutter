part of '../helpers.dart';

mixin DOverlay {
  static OverlayEntry? _entry;
  // static Timer? _timer;

  static void displayOverlay() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
  }

  static void insertOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    overlay.insert(_entry!);
  }

  static void removeOverlay() {
    _entry?.remove();
    _entry = null;
    // _timer?.cancel();
  }

  static void showOverlay({required BuildContext context, required Widget child}) {
    _entry = OverlayEntry(builder: (overlayContext) => child);
    insertOverlay(context);
    // _timer = Timer(const Duration(seconds: 5), () {
    //   removeOverlay();
    // });
  }
}

mixin OverlayStateMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  bool get isOverlayShown => _overlayEntry != null;

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    removeOverlay();
    super.didChangeDependencies();
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void toggleOverlay(Widget child) => isOverlayShown ? removeOverlay() : _insertOverlay(child);

  void _insertOverlay(Widget child) {
    _overlayEntry = OverlayEntry(
      builder: (_) => _dismissibleOverlay(child),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _dismissibleOverlay(Widget child) => Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.op(0.5),
              child: GestureDetector(
                onTap: removeOverlay,
              ),
            ),
          ),
          child,
        ],
      );
}
