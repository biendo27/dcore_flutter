part of '../livestream.dart';

class AddProductBody extends StatelessWidget {
  const AddProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.7.sh,
      child: BlocBuilder<LiveCubit, LiveState>(
        builder: (context, state) {
          if (state.liveOtherProducts.data.isEmpty) {
            return NoData();
          }

          return NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification is! ScrollEndNotification) return false;
              if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
              context.read<LiveCubit>().fetchLiveOtherProduct();
              return false;
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              itemCount: state.liveOtherProducts.data.length,
              itemBuilder: (context, index) {
                return LiveAddProductItem(product: state.liveOtherProducts.data[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
