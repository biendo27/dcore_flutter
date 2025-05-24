// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of '../utils.dart';

class DButtomNavBar extends StatefulWidget {
  int currentIndex;
  Function(int)? onTap;
  DButtomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  State<DButtomNavBar> createState() => _DButtomNavBarState();
}

class _DButtomNavBarState extends State<DButtomNavBar> {
  final List _items = [
    // NavBarItem(
    //   item: BottomNavigationBarItem(
    //     icon: SvgPicture.asset(Asset.svg.historyBooking, width: 18, height: 18),
    //     activeIcon: SvgPicture.asset(Asset.svg.historyBooking, width: 18, height: 18, colorFilter: ColorFilter.mode(secondaryColor, BlendMode.srcIn)),
    //     label: 'Lịch sử',
    //   ),
    //   page: const HomePassengerScreen(),
    // ),
    // NavBarItem(
    //   item: BottomNavigationBarItem(
    //     icon: SvgPicture.asset(Asset.svg.find, width: 18, height: 18),
    //     activeIcon: SvgPicture.asset(Asset.svg.find, width: 18, height: 18, colorFilter: ColorFilter.mode(secondaryColor, BlendMode.srcIn)),
    //     label: 'Tìm xe',
    //   ),
    //   page: const ProductScreen(),
    // ),
    // NavBarItem(
    //   item: const BottomNavigationBarItem(
    //     icon: Icon(FontAwesomeIcons.house, color: Colors.transparent),
    //     label: 'Trang chủ',
    //   ),
    //   page: const HomePassengerScreen(),
    // ),
    // NavBarItem(
    //   item: BottomNavigationBarItem(
    //     icon: SvgPicture.asset(Asset.svg.news, width: 18, height: 18),
    //     activeIcon: SvgPicture.asset(Asset.svg.news, width: 18, height: 18, colorFilter: ColorFilter.mode(secondaryColor, BlendMode.srcIn)),
    //     label: 'Tin tức',
    //   ),
    //   page: const NewsScreen(),
    // ),
    // NavBarItem(
    //   item: BottomNavigationBarItem(
    //     icon: SvgPicture.asset(Asset.svg.account, width: 18, height: 18),
    //     activeIcon: SvgPicture.asset(Asset.svg.account, width: 18, height: 18, colorFilter: ColorFilter.mode(secondaryColor, BlendMode.srcIn)),
    //     label: 'Tài khoản',
    //   ),
    //   page: const ProfileScreen(),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: List.generate(_items.length, (index) => _items[index].item),
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      // selectedItemColor: secondaryColor,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
    );
  }
}
