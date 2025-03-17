part of '../livestream.dart';

class SubLiveItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final double width;
  final void Function() onTap;
  const SubLiveItem({
    super.key,
    required this.icon,
    this.title = '',
    this.width = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmp = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon,
        AppText(title, style: AppStyle.text12.copyWith(color: AppColorLight.onPrimary)),
      ],
    );

    if (width > 0) {
      tmp = SizedBox(
        width: width,
        child: tmp,
      );
    }

    return InkWell(
      onTap: onTap,
      child: tmp,
    );
  }
}
