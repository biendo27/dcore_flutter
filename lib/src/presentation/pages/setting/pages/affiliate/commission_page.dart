part of '../../setting.dart';

class CommissionPage extends StatefulWidget {
  const CommissionPage({super.key});

  @override
  State<CommissionPage> createState() => _CommissionPageState();
}

class _CommissionPageState extends State<CommissionPage> {
  final ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    context.read<AffiliateCubit>().affiliateCommission(page);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent && context.read<AffiliateCubit>().state.transactionCommissions.length % 10 == 0) {
        page = page + 1;
        context.read<AffiliateCubit>().affiliateCommission(page);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.commission,
      body: BlocBuilder<AffiliateCubit, AffiliateState>(builder: (context, state) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppCustomColor.greyE9,
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment(-1.0, -1.0),
                    end: Alignment(1.0, 1.0),
                    colors: AppCustomColor.gradientContainer,
                    stops: [0.0, 0.2248, 0.7857, 1.0],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          context.text.commission,
                          style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                        ),
                        8.verticalSpace,
                        AppText(state.totalCommission.currencyVND, style: AppStyle.text32.copyWith(fontWeight: FontWeight.w600, color: AppColorLight.surface)),
                      ],
                    ),
                    DButton(
                      size: Size(110.w, 32.h),
                      onPressed: () async {
                        await DNavigator.goNamed(RouteNamed.withdrawCommission);
                        if (!context.mounted) return;
                        context.read<AffiliateCubit>().affiliateCommission(1);
                      },
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      backgroundColor: AppColorLight.surface,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      customChild: Row(
                        children: [
                          AppText(context.text.withdrawToWallet, style: AppStyle.text14.copyWith(color: AppCustomColor.orangeF5)),
                          8.horizontalSpace,
                          Icon(Icons.keyboard_double_arrow_right_rounded, size: 18.sp, color: AppCustomColor.orangeF5),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              16.verticalSpace,
              AppText(context.text.historyTransaction, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w600)),
              10.verticalSpace,
              ListHistoryTransactionCommissionBody(),
            ],
          ),
        );
      }),
    );
  }
}
