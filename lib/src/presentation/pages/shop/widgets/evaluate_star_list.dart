part of '../shop.dart';

class EvaluateStarList extends StatelessWidget {
  const EvaluateStarList({
    super.key,
    required this.numEvaluateStar,
  });
  final int numEvaluateStar;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            i < numEvaluateStar ? Icons.star : Icons.star,
            color: i < numEvaluateStar ? AppCustomColor.yellowFF : AppCustomColor.greyAC,
            size: 12.w,
          ),
      ],
    );
  }
}
