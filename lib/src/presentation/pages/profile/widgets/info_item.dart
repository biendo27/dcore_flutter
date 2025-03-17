part of '../profile.dart';

class InfoItem extends StatelessWidget {
  final int value;
  final String title;
  final void Function()? onTap;
  const InfoItem({
    super.key,
    this.value = 0,
    this.title = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap ?? () {},
        child: Column(
          children: [
            AppText(value.toString(), style: AppStyle.textBold16),
            AppText(title, style: AppStyle.text14.copyWith(color: AppCustomColor.greyC4)),
          ],
        ),
      ),
    );
  }
}
