part of '../utils.dart';

void showDataBottomSheet({
  String title = '',
  List<Widget> body = const [],
  Widget? bodyWidget,
  Widget? headerWidget,
  EdgeInsetsGeometry? contentPadding,
  Gradient? gradient,
  Function()? onTapClose,
  double initialChildSize = 0.4,
  double maxChildSize = 0.85,
  Color? colorTitle,
}) {
  assert(bodyWidget != null || body.isNotEmpty, 'bodyWidget or body must be provided');

  Widget header = Container(
    height: 56.h,
    padding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
    decoration: BoxDecoration(
      color: colorTitle ?? AppCustomColor.greyF5,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      gradient: gradient,
    ),
    child: Row(
      children: [
        headerWidget ?? 40.horizontalSpace,
        AppText(
          title,
          expandFlex: 1,
          style: AppStyle.text16.copyWith(color: colorTitle, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: () {
            DNavigator.back();
            onTapClose?.call();
          },
          child: Icon(
            FontAwesomeIcons.circleXmark,
            size: 20.sp,
            color: (colorTitle == AppColorLight.surface) ? AppColorLight.surface : AppColorLight.onSurface,
          ),
        ),
        (headerWidget != null) ? 0.horizontalSpace : 20.horizontalSpace,
      ],
    ),
  );

  showDModalBottomSheet(
    contentPadding: EdgeInsets.zero,
    maxChildSize: maxChildSize,
    initialChildSize: initialChildSize,
    bodyWidget: bodyWidget == null
        ? null
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header,
              bodyWidget,
            ],
          ),
    body: [
      header,
      ...body,
    ],
  );
}
