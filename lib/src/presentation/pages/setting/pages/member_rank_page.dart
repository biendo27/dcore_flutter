part of '../setting.dart';

class MemberRankPage extends StatefulWidget {
  const MemberRankPage({super.key});

  @override
  State<MemberRankPage> createState() => _MemberRankPageState();
}
// context.read<RankCubit>().setCurrentRank();

class _MemberRankPageState extends State<MemberRankPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.membershipLevel,
      body: BlocBuilder<RankCubit, RankState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  context.text.userRank,
                  style: AppStyle.text16.copyWith(fontWeight: FontWeight.bold),
                ),
                11.verticalSpace,
                DCachedImage(
                  url: state.rank.rank.image,
                  width: 50.w,
                  height: 50.w,
                  borderRadius: BorderRadius.circular(25.sp),
                ),
                11.verticalSpace,
                DButton(
                  onPressed: () {
                    context.read<RankCubit>().fetchRankHistory();
                    context.read<RankCubit>().setCurrentRank(state.rankHistory[0]);
                    DNavigator.goNamed(RouteNamed.memberRankHistory);
                  },
                  text: context.text.history,
                  size: Size(70.w, 28.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                ),
                10.verticalSpace,
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.rank.ranks.length,
                  itemBuilder: (context, index) {
                    return RankItem(
                      onTap: () {
                        DNavigator.goNamed(RouteNamed.memberRankDetail, extra: state.rank.ranks[index]);
                      },
                      rank: state.rank.ranks[index],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
