part of '../livestream.dart';

class TargetItem extends StatelessWidget {
  final Widget icon;
  final int progress;
  final int condition;
  final String title;
  const TargetItem({
    super.key,
    required this.icon,
    this.progress = 0,
    this.condition = 0,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          icon,
          5.verticalSpace,
          DHighlightText(
            text: '$progress/$condition',
            highlights: ['$progress'],
            style: AppStyle.text12.copyWith(color: AppColorLight.surface),
            highlightStyles: [AppStyle.text12.copyWith(color: AppCustomColor.redD0)],
          ),
          8.verticalSpace,
          AppText(
            title,
            style: AppStyle.text12.copyWith(color: AppColorLight.surface),
          ),
        ],
      ),
    );
  }
}
