part of '../shop.dart';

class FindProductCategorySection extends StatelessWidget {
  const FindProductCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterCubit, ProductFilterState>(
      builder: (context, state) {
        return Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: state.filter.category
              .map((e) => FilterOptionItem(
                    item: e.name,
                    isSelected: state.selectedCategory == e,
                    onTap: () {
                      context.read<ProductFilterCubit>().changeSelectedCategory(e);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
