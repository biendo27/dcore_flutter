part of '../livestream.dart';

class LivestreamLiveBody extends StatelessWidget {
  const LivestreamLiveBody({super.key});

  double childAspectRatio(BuildContext context) {
    int spaceWidth = Platform.isIOS ? 65 : 50;
    double width = (MediaQuery.sizeOf(context).width - spaceWidth) / 2;
    return width.w / 256.h;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveCubit, LiveState>(
      builder: (context, state) {
        if (state.liveList.data.isEmpty) {
          return NoData();
        }

        return Expanded(
          child: GridView.builder(
            itemCount: state.liveList.data.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.w,
              childAspectRatio: childAspectRatio(context),
            ),
            itemBuilder: (context, index) => LivestreamIntroItem(live: state.liveList.data[index]),
          ),
        );
      },
    );
  }
}
