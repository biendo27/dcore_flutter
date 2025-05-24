part of '../utils.dart';

void showDAboutDialog({
  required BuildContext context,
  String? applicationName,
  String? applicationVersion,
  String? applicationIcon,
  Widget? applicationLegalese,
  List<Widget>? children,
  Widget? actions,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAsset.images.mainIcon.path, width: 50.w, height: 50.w),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(applicationName ?? ''),
              Text(applicationVersion ?? '', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Địa chỉ: 123 Nguyễn Văn Linh, Quận 7, TPHCM'),
          Text('Điện thoại: 0941999999'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: false).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
