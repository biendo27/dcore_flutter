part of '../setting.dart';

class MemberRankHistoryBody extends StatelessWidget {
  const MemberRankHistoryBody({
    super.key,
    required this.rankHistory,
  });
  final List<Rank> rankHistory;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppCustomColor.greyF5,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: rankHistory.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container();
            } else {
              return MemberRankHistoryItem(
                rankData: rankHistory[index],
              );
            }
          },
        ),
      ),
    );
  }
}
