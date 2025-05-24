part of '../notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context
      ..read<NotificationCubit>().fetchNotificationList()
      ..read<UserListCubit>().fetchSuggestUser();

    final user = context.read<UserCubit>().state.user;
    context.read<MessageCubit>().getListMessage(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          context.text.notification,
          style: AppStyle.textBold14,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              context.read<UserListCubit>().setPageIndex(UserType.suggested.index);
              DNavigator.goNamed(RouteNamed.friend);
            },
          ),
          10.horizontalSpace,
        ],
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is! ScrollEndNotification) return false;
          if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
          context.read<UserListCubit>().fetchSuggestUser();
          return false;
        },
        child: RefreshIndicator(
          onRefresh: context.read<NotificationCubit>().fetchNotificationList,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        NotiActionItem(
                          leading: AppAsset.images.logo.path,
                          title: context.text.newFollower,
                          appNotification: state.notificationList.newFollower,
                          onTap: () {
                            context.read<NotificationCubit>().fetchNewFollowerNotificationDetail(init: true);
                            DNavigator.goNamed(RouteNamed.newFollower);
                          },
                        ),
                        NotiActionItem(
                          leading: AppAsset.images.logo.path,
                          title: context.text.activity,
                          appNotification: state.notificationList.activity,
                          onTap: () {
                            context.read<NotificationCubit>().fetchActivityNotificationDetail(init: true);
                            DNavigator.goNamed(RouteNamed.actionNotification);
                          },
                        ),
                        NotiActionItem(
                          leading: AppAsset.images.logo.path,
                          title: context.text.systemNotification,
                          systemNotification: state.notificationList.systemNotifications,
                          onTap: () {
                            context.read<NotificationCubit>().fetchSystemNotificationDetail(init: true);
                            DNavigator.goNamed(RouteNamed.systemNotification);
                          },
                        ),
                      ],
                    );
                  },
                ),
                BlocBuilder<MessageCubit, MessageState>(
                  builder: (context, state) {
                    final itemLength = state.conversation.length;
                    return Column(
                      children: List.generate(itemLength, (index) {
                        final message = state.conversation[index];
                        return message.user?.userid != 30
                            ? MessageItem(
                                onTap: () {
                                  DNavigator.goNamed(RouteNamed.message, extra: message);
                                },
                                avatar: message.user?.image ?? '',
                                userName: message.user?.userFullName ?? 'user',
                                messageContent: message.lastMsg ?? '',
                              )
                            : BlocBuilder<OrderListCubit, OrderListState>(
                                builder: (context, state) {
                                  return MessageItem(
                                    onTap: () {
                                      // context.read<OrderListCubit>()
                                      //   ..setCurrentOrder(state.userOrders.data.first)
                                      //   ..fetchOrderDetail();
                                      state.currentOrder.status.name.isNotEmpty
                                          ? context.read<MessageCubit>().onChatStore(state.currentOrder.store.user2)
                                          : DNavigator.goNamed(RouteNamed.message, extra: message);
                                      debugPrint('${state.currentOrder.store.user2}');
                                    },
                                    avatar: message.user?.image ?? '',
                                    userName: message.user?.userFullName ?? 'user',
                                    messageContent: message.lastMsg ?? '',
                                  );
                                },
                              );
                      }),
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

  @override
  void dispose() {
    AppConfig.context!.read<MessageCubit>().cancelListMessageSubscription();
    super.dispose();
  }
}
