part of '../utils.dart';

class ScaffoldLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  ScaffoldLayout({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Image.asset(AppAsset.icons.home.path, width: 20.w, height: 20.w),
      activeIcon: Image.asset(AppAsset.icons.homeActive.path, width: 20.w, height: 20.w),
      label: AppConfig.context!.text.home,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(AppAsset.icons.vnsShop.path, width: 20.w, height: 20.w),
      activeIcon: Image.asset(AppAsset.icons.vnsShopActive.path, width: 20.w, height: 20.w),
      label: AppConfig.context!.text.vnsShop,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(AppAsset.icons.plus.path, width: 38.w, height: 38.w),
      activeIcon: Image.asset(AppAsset.icons.plusActive.path, width: 38.w, height: 38.w),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(AppAsset.icons.bell.path, width: 20.w, height: 20.w),
      activeIcon: Image.asset(AppAsset.icons.bellActive.path, width: 20.w, height: 20.w),
      label: AppConfig.context!.text.notification,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(AppAsset.icons.user.path, width: 20.w, height: 20.w),
      activeIcon: Image.asset(AppAsset.icons.userActive.path, width: 20.w, height: 20.w),
      label: AppConfig.context!.text.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget bottomNavigationBar = BlocBuilder<PageCubit, PageState>(builder: (context, state) {
      return BottomNavigationBar(
        items: _items.map((e) => e).toList(),
        currentIndex: state.currentIndex,
        onTap: (index) => context.read<PageCubit>().handleNavigation(index, navigationShell),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppStyle.textBold12,
        unselectedLabelStyle: AppStyle.textBold10.copyWith(fontWeight: FontWeight.w600),
      );
    });

    if (Platform.isIOS) {
      bottomNavigationBar = SizedBox(height: 76.h, child: bottomNavigationBar);
    }

    return Column(
      children: [
        Expanded(child: navigationShell),
        bottomNavigationBar,
      ],
    );
  }
}
