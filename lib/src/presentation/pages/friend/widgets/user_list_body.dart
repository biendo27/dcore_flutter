part of '../friend.dart';

class UserListBody extends StatelessWidget {
  final List<AppUser> users;
  final UserType userType;
  final void Function() onFetch;
  final void Function() onRefresh;

  const UserListBody({
    super.key,
    this.users = const [],
    required this.userType,
    required this.onFetch,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Column(
        children: [
          60.verticalSpace,
          Image.asset(AppAsset.images.itemNotFound.path, width: 125.w),
          AppText(context.text.emptyList, style: AppStyle.textBold14),
        ],
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is! ScrollEndNotification) return false;
        if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
        onFetch();
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => UserActionItem(
            user: users[index],
            type: userType,
          ),
        ),
      ),
    );
  }
}
