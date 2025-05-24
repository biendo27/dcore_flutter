part of '../livestream.dart';

class LiveCensorFormItem extends StatelessWidget {
  final LiveCensorResultForm censorResult;
  final List<TextEditingController> pointControllers;
  final List<TextEditingController> reviewControllers;
  final bool readOnly;

  const LiveCensorFormItem({
    super.key,
    required this.censorResult,
    required this.pointControllers,
    required this.reviewControllers,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LiveCensorFormTitle(title: censorResult.categoryName),
        ...List.generate(censorResult.data.length, (index) {
          return LiveCensorFormBody(
            order: index,
            censorResult: censorResult.data[index],
            pointController: pointControllers[index],
            reviewController: reviewControllers[index],
            readOnly: readOnly,
          );
        }),
      ],
    );
  }
}
