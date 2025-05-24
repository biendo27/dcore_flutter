part of '../shop.dart';

class FindProductRatingSection extends StatelessWidget {
  const FindProductRatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterCubit, ProductFilterState>(
      builder: (context, state) {
        return Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: state.filter.rating
              .map((e) => FilterOptionItem(
                    item: e.name,
                    isSelected: state.selectedRating == e,
                    onTap: () {
                      context.read<ProductFilterCubit>().changeSelectedRating(e);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
