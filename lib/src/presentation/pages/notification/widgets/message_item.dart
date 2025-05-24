part of '../notification.dart';

class MessageItem extends StatelessWidget {
  final Function() onTap;
  final String avatar;
  final String userName;
  final String messageContent;

  const MessageItem({
    super.key,
    required this.onTap,
    this.avatar = '',
    this.userName = '',
    this.messageContent = '',
  });

  @override
  Widget build(BuildContext context) {
    String image = avatar.contains("https") ? avatar : ConstRes.itemBaseUrl + avatar;
    return ListTile(
      onTap: onTap,
      leading: image.isNotEmpty
          ? DCachedImage(
              url: image,
              width: 50.sp,
              height: 50.sp,
              borderRadius: BorderRadius.circular(50.sp),
              fit: BoxFit.cover,
            )
          : Image.asset(
              AppAsset.images.logo.path,
              width: 50.h,
              height: 50.h,
            ),
      title: AppText(userName, style: AppStyle.textBold14),
      subtitle: AppText(messageContent, style: AppStyle.text14),
    );
  }
}
