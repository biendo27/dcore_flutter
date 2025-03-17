part of '../setting.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.setting,
      isLoading: context.select((AuthBloc bloc) => bloc.state.isLoading),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            SettingItem(
              onTap: () => DNavigator.goNamed(RouteNamed.account),
              icon: AppAsset.svg.account,
              title: context.text.account,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () => DNavigator.goNamed(RouteNamed.notificationSetting),
              icon: AppAsset.svg.bell,
              title: context.text.notification,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () {
                DNavigator.goNamed(RouteNamed.affiliate);
              },
              icon: AppAsset.svg.affiliateBlack,
              title: context.text.affiliate,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () {
                if (AppGlobalValue.accessToken.isEmpty) return;
                context.read<RankCubit>().fetchRank();
                DNavigator.goNamed(RouteNamed.memberRank);
              },
              icon: AppAsset.svg.awardRank,
              title: context.text.membershipLevel,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () => DNavigator.goNamed(RouteNamed.deliveryAddress),
              icon: AppAsset.svg.mapPin,
              title: context.text.shippingAddress,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () => DNavigator.goNamed(RouteNamed.order),
              icon: AppAsset.svg.cart,
              title: context.text.purchareHistory,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () => DNavigator.goNamed(RouteNamed.language),
              icon: AppAsset.svg.language,
              title: context.text.language,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () => DNavigator.goNamed(RouteNamed.contact),
              icon: AppAsset.svg.headsetHelp,
              title: context.text.contact,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () => DNavigator.goNamed(RouteNamed.policyTerms),
              icon: AppAsset.svg.paper,
              title: context.text.policy,
              navigationIcon: Icons.arrow_forward_ios,
            ),
            SettingItem(
              onTap: () => _logout(context),
              icon: AppAsset.svg.power,
              title: context.text.logout,
              navigationIcon: null,
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDYesNoDialog(
      title: context.text.logout,
      message: context.text.logoutConfirmation,
      yesText: context.text.confirm,
      onYes: () {
        context.read<AuthBloc>().add(LogoutEvent());
        DNavigator.back();
      },
    );
  }
}
