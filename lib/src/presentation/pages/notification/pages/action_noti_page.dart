part of '../notification.dart';

class ActionNotiPage extends StatelessWidget {
  const ActionNotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.activity,
      onRefresh: () async => context.read<NotificationCubit>().fetchActivityNotificationDetail(),
      onLoadMore: () {},
      body: SingleChildScrollView(
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state.activity.data.isEmpty) {
              return const NoData();
            }
            return Column(
              children: [
                ...state.activity.data.map((e) => NotiAccountItem(content: e, enableTrailing: false)),
                10.verticalSpace,
                if (!state.activity.isLastPage)
                  DIconText(
                    onTap: () => context.read<NotificationCubit>().fetchActivityNotificationDetail(),
                    iconPosition: IconPosition.end,
                    icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
                    text: context.text.viewAll,
                  ),
                SuggestUserSection(),
              ],
            );
          },
        ),
      ),
    );
  }
}
