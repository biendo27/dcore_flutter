part of '../setting.dart';

class ListHistoryTransactionCommissionBody extends StatelessWidget {
  const ListHistoryTransactionCommissionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AffiliateCubit,AffiliateState>(
        builder: (context,state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.transactionCommissions.length,
          itemBuilder: (context, index) {
            final data = state.transactionCommissions[index];
            return ListHistoryTransactionItem(data: data);
          },
        );
      }
    );
  }
}
