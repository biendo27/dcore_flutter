part of '../shop.dart';

class FindProductPriceRangeSection extends StatelessWidget {
  final void Function() onTap;
  const FindProductPriceRangeSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterCubit, ProductFilterState>(
      builder: (context, state) {
        return Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: state.filter.priceRange
              .map((e) => FilterOptionItem(
                    item: e.name,
                    isSelected: state.selectedPriceRange == e,
                    onTap: () {
                      onTap.call();
                      context.read<ProductFilterCubit>().changeSelectedPriceRange(e);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
