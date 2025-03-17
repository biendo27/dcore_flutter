part of '../livestream.dart';

class DutyBody extends StatelessWidget {
  const DutyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 0.45.sh),
        _background(),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    10.horizontalSpace,
                    SvgPicture.asset(
                      AppAsset.svg.letter,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                    5.horizontalSpace,
                    AppText(
                      context.text.duty,
                      style: AppStyle.text14.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                20.verticalSpace,
                Expanded(
                  child: BlocBuilder<LiveMissionCubit, LiveMissionState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Center(child: AppLoading());
                      }

                      if (state.missions.data.isEmpty) {
                        return NoData();
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.missions.data.length,
                        itemBuilder: (context, index) {
                          return DutyItem(missionData: state.missions.data[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _background() {
    return Container(
      height: 60.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // background: linear-gradient(178.68deg, rgba(245, 136, 34, 0.5) -54.42%, #FFFFFF 21.6%);
          colors: [
            Color(0xFFF58822).op(0.3),
            Colors.white,
          ],
          stops: [0.2, 0.8],
        ),
      ),
    );
  }
}
