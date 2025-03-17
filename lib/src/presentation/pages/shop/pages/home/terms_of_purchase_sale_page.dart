part of '../../shop.dart';

class TermsOfPurchaseSalePolicyPage extends StatelessWidget {
  const TermsOfPurchaseSalePolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.termsOfPurchaseSalePolicy,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<ConfigCubit, ConfigState>(
          builder: (context, state) {
            return HtmlWidget(
              state.termOfSalePolicy,
              textStyle: AppStyle.text14,
            );
          },
        ),
      ),
    );
  }
}
