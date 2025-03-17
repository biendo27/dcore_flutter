part of '../shop.dart';

class ProductCartVariantInfo extends StatelessWidget {
  final List<Attribute> attributes;
  final List<ValueNotifier<AttributeValue>> attributeNotifiers;
  const ProductCartVariantInfo({
    super.key,
    required this.attributes,
    required this.attributeNotifiers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          attributes.length,
          (index) => ProductCartVariantItemInfo(
            attribute: attributes[index],
            attributeNotifier: attributeNotifiers[index],
            attributeNotifiers: attributeNotifiers,
          ),
        ),
      ),
    );
  }
}

class ProductCartVariantItemInfo extends StatelessWidget {
  final Attribute attribute;
  final ValueNotifier<AttributeValue> attributeNotifier;
  final List<ValueNotifier<AttributeValue>> attributeNotifiers;
  const ProductCartVariantItemInfo({
    super.key,
    required this.attribute,
    required this.attributeNotifier,
    required this.attributeNotifiers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          attribute.name,
          style: AppStyle.text12.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        8.verticalSpace,
        ListOfCriteria(
          items: attribute.values,
          width: 67.w,
          attributeNotifier: attributeNotifier,
          attributeNotifiers: attributeNotifiers,
        ),
        12.verticalSpace,
      ],
    );
  }
}
