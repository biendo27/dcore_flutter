part of '../shop.dart';

class FindProductPriceRangeInput extends StatelessWidget {
  final TextEditingController fromPriceController;
  final TextEditingController toPriceController;

  const FindProductPriceRangeInput({super.key, required this.fromPriceController, required this.toPriceController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DTextField(
          expandFlex: 1,
          controller: fromPriceController,
          hint: context.text.minimum.toUpperCase(),
          textAlign: TextAlign.center,
          type: DTextInputType.number,
          fillColor: AppColorLight.onPrimary,
          margin: EdgeInsets.zero,
          onChanged: (value) {
            context.read<ProductFilterCubit>().changeSelectedPriceRange(PriceRangeFilter());
          },
        ),
        10.horizontalSpace,
        DTextField(
          expandFlex: 1,
          controller: toPriceController,
          hint: context.text.maximum.toUpperCase(),
          textAlign: TextAlign.center,
          type: DTextInputType.number,
          fillColor: AppColorLight.onPrimary,
          margin: EdgeInsets.zero,
          onChanged: (value) {
            context.read<ProductFilterCubit>().changeSelectedPriceRange(PriceRangeFilter());
          },
        ),
      ],
    );
  }
}
