part of '../shop.dart';

class FindProductServicePromotionSection extends StatelessWidget {
  const FindProductServicePromotionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterCubit, ProductFilterState>(
      builder: (context, state) {
        return Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: state.filter.servicePromotion
              .map((e) => FilterOptionItem(
                    item: e.name,
                    isSelected: state.selectedServicePromotion == e,
                    onTap: () {
                      context.read<ProductFilterCubit>().changeSelectedServicePromotion(e);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
