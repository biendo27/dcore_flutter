part of '../notification.dart';

class MessageActionItem extends StatelessWidget {
  final String leading;
  final void Function()? onTap;

  const MessageActionItem({
    super.key,
    required this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(leading, width: 50.w, height: 50.w),
      title: AppText('Action Item', style: AppStyle.textBold14),
      subtitle: AppText('Action Item Description', style: AppStyle.text14),
      trailing: Image.asset(AppAsset.icons.waveHand.path, width: 20.w, height: 20.w),
    );
  }
}
