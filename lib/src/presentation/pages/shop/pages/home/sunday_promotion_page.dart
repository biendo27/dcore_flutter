part of '../../shop.dart';

class SundayPromotionPage extends StatefulWidget {
  const SundayPromotionPage({super.key});

  @override
  State<SundayPromotionPage> createState() => _SundayPromotionPageState();
}

class _SundayPromotionPageState extends State<SundayPromotionPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      appBarBackgroundColor: Colors.transparent,
      backgroundImage: AppAsset.images.promotionalProgram.path,
      backgroundColor: Colors.transparent,
      title: context.text.sundayPromotion,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            20.verticalSpace,
            AppText(
              context.text.happySunday,
              textAlign: TextAlign.center,
              style: AppStyle.text30.copyWith(fontWeight: FontWeight.w700, color: AppCustomColor.orangeF1),
            ),
            AppText(
              DateTime.now().dateValueString,
              style: AppStyle.text20.copyWith(fontWeight: FontWeight.w700),
            ),
            10.verticalSpace,
            BannerItem(
              banner: StoreBanner(
                image: "ADS Example",
                url: "https://www.google.com",
              ),
            ),
            40.verticalSpace,
            AppText(
              context.text.shoppingSpree.toUpperCase(),
              style: AppStyle.text20.copyWith(
                color: AppCustomColor.orangeF1,
                fontWeight: FontWeight.w700,
                shadows: [
                  BoxShadow(
                    color: AppColorLight.onSurface.op(0.1),
                    offset: Offset(0, 4),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
