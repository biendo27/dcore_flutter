part of '../utils.dart';

/// It shows a dialog with a title and a body.
///
/// Args:
///   context (BuildContext): BuildContext
///   body (List&lt;Widget&gt;): The body of the dialog.
///   actions (List&lt;Widget&gt;): List of widgets to show in the dialog's action buttons.
///   actionsPadding (EdgeInsetsGeometry): The padding of the actions.
///   insetPadding (EdgeInsets): The padding of the dialog box.
///   actionsAlignment (MainAxisAlignment): MainAxisAlignment.spaceBetween,
///   title (String): The title of the dialog
///
void showDDiaLog(
  BuildContext context, {
  List<Widget>? body,
  List<Widget>? actions,
  EdgeInsetsGeometry? actionsPadding,
  EdgeInsets? insetPadding,
  MainAxisAlignment? actionsAlignment,
  required String title,
  bool enableBackButton = true,
}) {
  showDialog(
    useRootNavigator: false,
    barrierLabel: 'DDialog',
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.white,
        elevation: 0,
        actionsPadding: actionsPadding ?? const EdgeInsets.fromLTRB(10, 0, 10, 10),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        // buttonPadding: const EdgeInsets.all(10),
        insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        actionsAlignment: actionsAlignment,
        title: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: enableBackButton ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            if (enableBackButton) const SizedBox(width: 48),
            AppText(title, style: AppStyle.text20),
            if (enableBackButton)
              IconButton(
                style: IconButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero),
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context, rootNavigator: false).pop(),
              ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: body!,
          ),
        ),
        actions: actions,
      );
    },
  );
}
