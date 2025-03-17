part of '../utils.dart';

class BottomMenuItemWidget extends StatelessWidget {
  final String title;
  final String asset;
  final bool isEnabled;
  final bool isEnabledIcon;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final int badgeIndex;
  final bool enableBadge;
  const BottomMenuItemWidget({
    super.key,
    required this.title,
    required this.asset,
    required this.isEnabled,
    this.onPressed,
    this.width,
    this.height,
    this.isEnabledIcon = true,
    this.badgeIndex = 0,
    this.enableBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon = SvgPicture.asset(
      asset,
      // colorFilter: ColorFilter.mode(
      //   !isEnabledIcon ? Colors.transparent : (isEnabled: Colors.black),
      //   BlendMode.srcIn,
      // ),
      width: width ?? 18,
      height: height ?? 18,
    );

    if (badgeIndex > 0 && enableBadge) {
      icon = Badge(
        backgroundColor: const Color(0xFFED5151),
        offset: const Offset(10, -5),
        textColor: Colors.white,
        label: Text(badgeIndex > 9 ? '9+' : '$badgeIndex', style: const TextStyle(fontSize: 10)),
        child: icon,
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              icon,
              3.verticalSpace,
              AppText(
                title,
                // style: TextStyle(fontSize: 12, color: isEnabled ? secondaryColor : Colors.black),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarCurveItem {
  final String title;
  final String asset;
  final int? badgeIndex;

  const NavBarCurveItem({
    required this.title,
    required this.asset,
    this.badgeIndex,
  });
}

class NavBarItem {
  final BottomNavigationBarItem item;
  final Widget page;

  NavBarItem({required this.item, required this.page});
}
