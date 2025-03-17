part of '../../shop.dart';

class UserRequestPage extends StatefulWidget {
  const UserRequestPage({super.key});

  @override
  State<UserRequestPage> createState() => _UserRequestPageState();
}

class _UserRequestPageState extends State<UserRequestPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.userRequest,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColorLight.onSurface,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: AppStyle.text12.copyWith(fontWeight: FontWeight.w400),
              labelPadding: EdgeInsets.symmetric(horizontal: 9.w),
              onTap: (index) {},
              tabs: [
                Tab(text: context.text.processing),
                Tab(text: context.text.processed),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  UserRequestItem(),
                  UserRequestItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
