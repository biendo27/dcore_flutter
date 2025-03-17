part of '../../setting.dart';

class AffiliatePage extends StatefulWidget {
  const AffiliatePage({super.key});

  @override
  State<AffiliatePage> createState() => _AffiliatePageState();
}

class _AffiliatePageState extends State<AffiliatePage> {
  late bool isRegister;
  int page = 1;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    isRegister = context.read<UserCubit>().state.user.isAffiliate;
    if (isRegister) {
      context.read<AffiliateCubit>().affiliateHome(page);
      context.read<AffiliateCubit>().affiliateInfo();
    } else {
      context.read<AffiliateCubit>().affiliateRequest();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent && context.read<AffiliateCubit>().state.productSaves.length % 10 == 0) {
        page = page + 1;
        context.read<AffiliateCubit>().affiliateCommission(page);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.affiliate,
      actions: actions,
      body: !isRegister ? NotRegisterAffiliateBody() : RegisteredAffiliateBody(scrollController: scrollController),
    );
  }

  List<Widget> get actions {
    return [
      GradientButton(
        size: Size(110.w, 42.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
        onPressed: () async {
          if (!isRegister) {
            DNavigator.goNamed(RouteNamed.affiliateRegister);
          } else {
            await DNavigator.goNamed(RouteNamed.findCommissionProduct);
            if (!mounted) return;
            context.read<AffiliateCubit>().affiliateHome(1);
          }
        },
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        text: !isRegister ? context.text.register : context.text.addProduct,
        customChild: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppAsset.svg.affiliate, width: 20.w, height: 20.w),
            5.horizontalSpace,
            AppText(!isRegister ? context.text.register : context.text.addProduct, style: AppStyle.text12.copyWith(color: AppColorLight.surface)),
          ],
        ),
      ),
      15.horizontalSpace,
    ];
  }
}
