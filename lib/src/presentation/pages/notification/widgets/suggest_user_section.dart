part of '../notification.dart';

class SuggestUserSection extends StatelessWidget {
  const SuggestUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace,
        DIconText(
          text: context.text.suggestAccount,
          icon: Icon(Icons.info_outline_rounded, size: 16.sp),
          textStyle: AppStyle.textBold14,
          iconPosition: IconPosition.end,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        BlocBuilder<UserListCubit, UserListState>(
          builder: (context, state) {
            return Column(
              children: state.suggestUser.data.map((e) {
                return UserActionItem(
                  user: e,
                  type: UserType.suggested,
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
