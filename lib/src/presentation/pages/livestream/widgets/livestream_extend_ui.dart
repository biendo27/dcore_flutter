part of '../livestream.dart';

class LivestreamExtendUI extends StatelessWidget {
  final LiveRole liveRole;

  const LivestreamExtendUI({
    super.key,
    this.liveRole = LiveRole.host,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    ValueNotifier<Offset> pinnedPosition = ValueNotifier<Offset>(
      Offset(screenWidth * 0.015, screenHeight * 0.67),
    );

    return SafeArea(
      top: true,
      bottom: false,
      child: Unfocused(
        child: Stack(
          children: [
            Container(
              padding: MediaQuery.viewInsetsOf(context),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.verticalSpace,
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w), child: LivestreamHeaderView(liveRole: liveRole)),
                  5.verticalSpace,
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: LivestreamSubHeaderView(liveRole: liveRole)),
                  100.verticalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LivestreamCommentView(liveRole: liveRole),
                        BlocBuilder<LiveCommentCubit, LiveCommentState>(
                          builder: (context, state) {
                            if (state.liveExtraInfo.pinned.isPinned) {
                              return 52.verticalSpace;
                            }
                            return SizedBox.shrink();
                          },
                        ),
                        Builder(
                          builder: (context) {
                            final pinProduct = context.select((LiveCubit bloc) => bloc.state.pinProduct);
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300), // Thời gian hiệu ứng
                              transitionBuilder: (child, animation) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                              child: pinProduct.isPinned
                                  ? Container(
                                      key: ValueKey('pinnedProduct'), // Mỗi trạng thái cần một key khác nhau
                                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: PinProductWidget(
                                        liveRole: liveRole,
                                        product: pinProduct,
                                      ),
                                    )
                                  : SizedBox.shrink(
                                      key: ValueKey('empty'), // Key cho trạng thái không ghim
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  LivestreamBottomView(liveRole: liveRole),
                  // 10.verticalSpace,
                ],
              ),
            ),
            liveRole == LiveRole.host
                ? BlocBuilder<LiveCommentCubit, LiveCommentState>(
                    builder: (context, state) {
                      if (state.liveExtraInfo.pinned.isPinned) {
                        return ValueListenableBuilder<Offset>(
                          valueListenable: pinnedPosition,
                          builder: (context, position, child) {
                            return Positioned(
                              left: position.dx,
                              top: position.dy,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  pinnedPosition.value = Offset(
                                    (position.dx + details.delta.dx).clamp(0.0, 1.sw - 130.0.w),
                                    (position.dy + details.delta.dy).clamp(0.0, 1.sh - 130.0.h),
                                  );
                                },
                                child: LivestreamCommentItem(
                                  liveRole: liveRole,
                                  comment: state.liveExtraInfo.pinned,
                                  isPinned: true,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return SizedBox.shrink();
                    },
                  )
                : BlocBuilder<LiveCommentCubit, LiveCommentState>(
                    builder: (context, state) {
                      if (state.liveExtraInfo.pinned.isPinned) {
                        return ValueListenableBuilder<Offset>(
                          valueListenable: pinnedPosition,
                          builder: (context, position, child) {
                            return Positioned(
                              left: position.dx,
                              top: position.dy,
                              child: LivestreamCommentItem(
                                liveRole: liveRole,
                                comment: state.liveExtraInfo.pinned,
                                isPinned: true,
                              ),
                            );
                          },
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
