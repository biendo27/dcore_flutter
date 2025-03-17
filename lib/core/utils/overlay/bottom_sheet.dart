part of '../utils.dart';

void showDModalBottomSheet({
  List<Widget> body = const [],
  Widget? bodyWidget,
  double initialChildSize = 0.4,
  double maxChildSize = 0.6,
  EdgeInsets contentPadding = const EdgeInsets.all(15),
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool enableDrag = true,
}) {
  showModalBottomSheet(
    backgroundColor: AppColorLight.surface,
    isScrollControlled: isScrollControlled,
    enableDrag: enableDrag,
    context: AppConfig.context!,
    isDismissible: isDismissible,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp))),
    builder: (context) => Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: SafeArea(
        child: bodyWidget ??
            DraggableScrollableSheet(
              initialChildSize: initialChildSize,
              maxChildSize: maxChildSize,
              expand: false,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  padding: contentPadding.w,
                  child: Column(children: body),
                );
              },
            ),
      ),
    ),
  );
}
