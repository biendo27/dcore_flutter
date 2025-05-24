// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of '../utils.dart';

class DButtomNavBarCurve extends StatelessWidget {
  int currentIndex;
  PageController pageController;
  Function(int)? onTap;
  DButtomNavBarCurve({
    super.key,
    required this.currentIndex,
    required this.pageController,
    this.onTap,
  });

  List<NavBarCurveItem> passengerItems = [
    // NavBarCurveItem(title: 'Lịch sử', asset: Asset.svg.historyBooking),
    // NavBarCurveItem(title: 'Tìm xe', asset: Asset.svg.find),
    // NavBarCurveItem(title: 'Trang chủ', asset: Asset.svg.home),
    // NavBarCurveItem(title: 'Tin tức', asset: Asset.svg.news),
    // NavBarCurveItem(title: 'Tài khoản', asset: Asset.svg.account),
  ];

  List<NavBarCurveItem> driverItems = [
    // NavBarCurveItem(title: 'Báo giá', asset: Asset.svg.quote, badgeIndex: 5),
    // NavBarCurveItem(title: 'Lịch sử', asset: Asset.svg.historyBooking),
    // NavBarCurveItem(title: 'Trang chủ', asset: Asset.svg.home),
    // NavBarCurveItem(title: 'Tin tức', asset: Asset.svg.news),
    // NavBarCurveItem(title: 'Tài khoản', asset: Asset.svg.account),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      shape: const AutomaticNotchedShape(RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
      // shape: const CircularNotchedRectangle(),
      height: 60,
      elevation: 10,
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
      notchMargin: 6,
      shadowColor: Colors.black,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          passengerItems.length,
          (index) => BottomMenuItemWidget(
            title: passengerItems[index].title,
            asset: passengerItems[index].asset,
            isEnabled: currentIndex == index,
            onPressed: () => onTap!(index),
          ),
        ),
      ),
    );
  }
}
