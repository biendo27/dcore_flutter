part of '../profile.dart';

enum TabItemType {
  video,
  favorite,
  collection;

  String title(BuildContext context) {
    return switch (this) {
      TabItemType.video => context.text.video,
      TabItemType.favorite => context.text.favorite,
      TabItemType.collection => context.text.like,
    };
  }

  String get icon {
    return switch (this) {
      TabItemType.video => AppAsset.svg.home,
      TabItemType.favorite => AppAsset.svg.fire,
      TabItemType.collection => AppAsset.svg.heartLove,
    };
  }

  String get activeIcon {
    return switch (this) {
      TabItemType.video => AppAsset.svg.homeActive,
      TabItemType.favorite => AppAsset.svg.fireActive,
      TabItemType.collection => AppAsset.svg.heartLoveActive,
    };
  }
}

class TabItem extends StatelessWidget {
  final TabItemType type;
  final bool isActive;
  const TabItem({
    super.key,
    this.type = TabItemType.video,
    this.isActive = false,
  });

  String get icon {
    return isActive ? type.activeIcon : type.icon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        5.verticalSpace,
        AppGradientText(
          type.title(context),
          style: AppStyle.text14.copyWith(color: AppCustomColor.greyC4),
          gradient: LinearGradient(
            colors: AppCustomColor.gradientContainer,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        5.verticalSpace,
      ],
    );
  }
}
