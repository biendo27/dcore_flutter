part of '../setting.dart';

class MemberRankHistoryPage extends StatefulWidget {
  const MemberRankHistoryPage({super.key});

  @override
  State<MemberRankHistoryPage> createState() => _MemberRankHistoryPageState();
}

class _MemberRankHistoryPageState extends State<MemberRankHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.memberRankHistory,
      body: BlocBuilder<RankCubit, RankState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                color: AppColorLight.surface,
                padding: EdgeInsets.only(bottom: 5.h),
                child: AppText(
                  context.text.current,
                  style: AppStyle.text12,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: MemberRankHistoryItem(
                  rankData: state.currentRank,
                  latestRankId: state.currentRank.id,
                ),
              ),
              5.verticalSpace,
              MemberRankHistoryBody(
                rankHistory: state.rankHistory,
              ),
            ],
          );
        },
      ),
    );
  }
}
