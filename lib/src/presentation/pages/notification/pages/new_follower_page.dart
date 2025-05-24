part of '../notification.dart';

class NewFollowerPage extends StatelessWidget {
  const NewFollowerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.newFollower,
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is! ScrollEndNotification) return false;
          if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
          context.read<UserListCubit>().fetchSuggestUser();
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async => context.read<NotificationCubit>().fetchNewFollowerNotificationDetail(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        ...state.newFollower.data.map((e) => NotiAccountItem(content: e)),
                        10.verticalSpace,
                        if (!state.newFollower.isLastPage)
                          DIconText(
                            onTap: () => context.read<NotificationCubit>().fetchNewFollowerNotificationDetail(),
                            iconPosition: IconPosition.end,
                            icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
                            text: context.text.viewAll,
                          ),
                      ],
                    );
                  },
                ),
                SuggestUserSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
