part of '../shop.dart';

class UserRequestItem extends StatelessWidget {
  const UserRequestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAsset.images.itemNotFound.path, width: 125.w),
        AppText(
          context.text.emptyList,
          style: AppStyle.textBold14,
        ),
      ],
    );
  }
}
