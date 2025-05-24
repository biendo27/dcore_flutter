part of '../livestream.dart';

class PinProductBody extends StatelessWidget {
  const PinProductBody({super.key});

  void _addProductToPinList(BuildContext context) {
    DNavigator.back();
    showDataBottomSheet(
      title: context.text.addProduct,
      contentPadding: EdgeInsets.zero,
      bodyWidget: AddProductBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.sh - MediaQuery.viewInsetsOf(context).bottom,
      // padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: BlocBuilder<LiveCubit, LiveState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.currentLive.allProducts.length + 1,
            padding: EdgeInsets.only(top: 10.h),
            itemBuilder: (context, index) {
              if (index == state.currentLive.allProducts.length) {
                return InkWell(
                  onTap: () => _addProductToPinList(context),
                  child: Container(
                    padding: EdgeInsets.all(10),
                      color: AppColorLight.onSurface.op(0.5),

                      child: Center(child: Icon(Icons.add, size: 40.w, color: AppColorLight.surface))),
                );
              }
              return ListProductOverHozviewItem(product: state.currentLive.allProducts[index]);
            },
          );
        },
      ),
    );
  }
}
