part of '../home.dart';

class IconVideo extends StatelessWidget {
  final String icon;
  final void Function()? onTap;
  final double? width;
  final double? height;
  const IconVideo({
    super.key,
    this.icon = '',
    this.onTap,
    this.width,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.op(0.1),
              spreadRadius: 1,
              blurRadius: 9,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: SvgPicture.asset(
          icon,
          width: width ?? 30.w,
          height: height ?? 30.h,
        ),
      ),
    );
  }
}
