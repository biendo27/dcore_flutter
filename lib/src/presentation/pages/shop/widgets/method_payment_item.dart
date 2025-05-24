part of '../shop.dart';

class MethodPaymentItem extends StatelessWidget {
  final String image;
  final String title;
  final int methodId;
  final ValueListenable<int> selectedValue;
  final void Function(int?)? onChange;

  const MethodPaymentItem({
    super.key,
    required this.image,
    required this.title,
    required this.selectedValue,
    required this.methodId,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange?.call(methodId),
      child: Row(
        children: [
          DCachedImage(
            url: image,
            width: 40.w,
            fit: BoxFit.contain,
          ),
          12.horizontalSpace,
          AppText(title, style: AppStyle.text14),
          Spacer(),
          ValueListenableBuilder(
            valueListenable: selectedValue,
            builder: (context, value, child) {
              return Radio(
                value: methodId,
                groupValue: value,
                onChanged: onChange,
              );
            },
          ),
        ],
      ),
    );
  }
}
