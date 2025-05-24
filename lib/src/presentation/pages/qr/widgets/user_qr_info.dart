part of '../qr.dart';

class QrView extends StatelessWidget {
  final AppUser user;
  const QrView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      margin: EdgeInsets.all(20).w,
      decoration: BoxDecoration(
        color: AppColorLight.surface,
        borderRadius: BorderRadius.circular(19.r),
        border: GradientBoxBorder(
          width: 2.w,
          gradient: LinearGradient(colors: AppCustomColor.gradientContainer),
        ),
      ),
      child: Column(
        children: [
          // QR Code
          QrImageView(
            data: jsonEncode(AppUser(id: user.id, username: user.username, bio: user.bio, image: user.image).toJson()),
            version: QrVersions.auto,
            // 0
          ),
          // Username
          AppText(
            '@${user.username}',
            style: AppStyle.text14,
          ),
        ],
      ),
    );
  }
}
