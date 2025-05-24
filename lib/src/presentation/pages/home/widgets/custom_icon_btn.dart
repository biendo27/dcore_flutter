part of '../home.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final Function()? onTap;
  final int? count;
  final String? title;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.count,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SvgPicture.asset(icon, width: 25.w, height: 25.h,fit: BoxFit.cover,),
        ),
        if (title != null) ...[
          2.verticalSpace,
          Text(
            title!,
            style: AppStyle.text10.copyWith(color: AppColorLight.onSurface),
          ),
        ],
        if (count != null && count! > -1)
          Text(
            count.toString(),
            style: AppStyle.text10.copyWith(color: AppColorLight.surface),
          ),
      ],
    );
  }
}
