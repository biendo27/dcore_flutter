part of '../setting.dart';

class CommissionProductFilterResult extends StatelessWidget {
  const CommissionProductFilterResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<AffiliateCubit, AffiliateState>(
        builder: (context, state) {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 16.h),
            itemCount: state.products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListAffiliateProductItem(
                isAdded: true,
                product: product,
              );
            },
          );
        },
      ),
    );
  }
}
