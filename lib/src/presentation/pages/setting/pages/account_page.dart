part of '../setting.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.account,
      isLoading: context.select((AuthBloc bloc) => bloc.state.isLoading),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context.text.accountInformation,
              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w600),
            ),
            10.verticalSpace,
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Column(
                  children: [
                    DTitleAndText(
                      title: '${context.text.phone}:',
                      text: state.user.phone,
                      margin: EdgeInsets.zero,
                      titleStyle: AppStyle.text14,
                      textStyle: AppStyle.text14.copyWith(color: AppCustomColor.greyC4),
                    ),
                    14.verticalSpace,
                    DTitleAndText(
                      title: '${context.text.email}:',
                      text: state.user.emailDisplay,
                      margin: EdgeInsets.zero,
                      titleStyle: AppStyle.text14,
                      textStyle: AppStyle.text14.copyWith(color: AppCustomColor.greyC4),
                    ),
                    14.verticalSpace,
                    DTitleAndText(
                      title: '${context.text.birthDay}:',
                      text: state.user.birthdayDisplay,
                      margin: EdgeInsets.zero,
                      titleStyle: AppStyle.text14,
                      textStyle: AppStyle.text14.copyWith(color: AppCustomColor.greyC4),
                    ),
                  ],
                );
              },
            ),
            20.verticalSpace,
            AppText(context.text.password, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w600)),
            10.verticalSpace,
            InkWell(
              onTap: () => DNavigator.goNamed(RouteNamed.changePassword),
              child: Row(
                children: [
                  AppText(context.text.changePassword),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 15.sp),
                ],
              ),
            ),
            14.verticalSpace,
            InkWell(
              onTap: _onDeleteAccountPermanentlyTap,
              child: Row(
                children: [
                  AppText(context.text.deleteAccountPermanently),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 15.sp),
                ],
              ),
            ),
            14.verticalSpace,
            AppText(context.text.accountContentPermanentlyLocked, style: AppStyle.text12.copyWith(color: AppCustomColor.greyC4)),
            AppText(context.text.cancelWithin30Days, maxLines: 2, style: AppStyle.text12.copyWith(color: AppCustomColor.greyC4)),
          ],
        ),
      ),
    );
  }

  _onDeleteAccountPermanentlyTap() {
    TextEditingController controller = TextEditingController();
    showDataBottomSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.3,
      title: AppConfig.context!.text.deleteAccountPermanently,
      bodyWidget: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: Column(
          children: [
            DTextField(
              controller: controller,
              hint: AppConfig.context!.text.password,
              type: DTextInputType.password,
            ),
            15.verticalSpace,
            DButton(
              text: AppConfig.context!.text.apply,
              onPressed: () {
                DNavigator.back();
                _onApplyDeleteAccountPermanently(controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  _onApplyDeleteAccountPermanently(String password) {
    showDYesNoDialog(
      title: AppConfig.context!.text.deleteAccountPermanently,
      message: AppConfig.context!.text.deleteAccountPermanentlyConfirmation,
      yesText: AppConfig.context!.text.confirm,
      noText: AppConfig.context!.text.cancel,
      onYes: () {
        AppConfig.context!.read<AuthBloc>().add(DeleteAccountPermanentlyEvent(password: password));
        DNavigator.back();
      },
    );
  }
}
