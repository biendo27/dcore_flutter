part of '../../shop.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.support,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DTextField(
              controller: searchController,
              prefix: Icon(Icons.search, size: 25.sp, color: AppColorLight.scrim),
              suffix: !kDebugMode ? null : Icon(FontAwesomeIcons.microphone, size: 20.sp, color: AppColorLight.scrim),
              hint: "${context.text.search}...",
              fillColor: const Color.fromRGBO(242, 242, 242, 1),
              // contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
            ),
            Row(
              children: [
                AppText(
                  context.text.request,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => DNavigator.goNamed(RouteNamed.userRequest),
                  child: AppText(
                    context.text.userRequest,
                    style: AppStyle.text12.copyWith(fontWeight: FontWeight.w400, color: AppCustomColor.blue1F),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                RequestItem(imgage: AppAsset.svg.noteBook, title: context.text.followOrder),
                30.horizontalSpace,
                RequestItem(imgage: AppAsset.svg.noteXmark, title: context.text.requestCancelOrder),
                30.horizontalSpace,
                RequestItem(imgage: AppAsset.svg.cashCoin, title: context.text.requestRefund),
              ],
            ),
            20.verticalSpace,
            AppText(context.text.faq, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
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
                Tab(text: context.text.suggest),
                Tab(text: context.text.shopping),
                Tab(text: context.text.sale),
                Tab(text: context.text.payment),
                Tab(text: context.text.order),
              ],
            ),
            SizedBox(
              height: 260.h,
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: AppText('Suggest $index'),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: AppText('Shopping $index'),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: AppText('Sale $index'),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: AppText('Payment $index'),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: AppText('Order $index'),
                      );
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(context.text.viewAll),
                  4.horizontalSpace,
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            AppText(context.text.learnMore, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
            10.verticalSpace,
            Row(
              children: [
                Image.asset(AppAsset.images.message.path, width: 50.w, height: 50.w),
                12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(context.text.callVnsShop, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                    5.verticalSpace,
                    AppText(context.text.support24_7, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300, color: AppCustomColor.grey50)),
                  ],
                )
              ],
            ),
            16.verticalSpace,
            Row(
              children: [
                Image.asset(AppAsset.images.contact.path, width: 50.w, height: 50.w),
                12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(context.text.contact, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                    5.verticalSpace,
                    AppText(context.text.support24_7, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300, color: AppCustomColor.grey50)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
