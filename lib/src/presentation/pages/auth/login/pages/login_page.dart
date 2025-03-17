part of '../../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginSuccess() {
    context.read<SoundCubit>()
      ..fetchSoundSuggestedList()
      ..fetchSoundBookmarked();

    context
      ..read<ReportCubit>().fetchReportList(ReportType.post)
      ..read<GiftCubit>().fetchGiftList()
      ..read<WalletCubit>().walletPackage(onSuccess: (productIds) {
        AppConfig.context!.read<InAppCubit>().init(productIds);
      });

    context.read<WalletCubit>()
      ..fetchWallet(1)
      ..walletPolicy()
      ..walletPaymentMethod()
      ..walletPackage();

    context.read<LiveEventCubit>().getLiveEventList(isInit: true);

    context
      ..read<StoreHomeCubit>().fetchStoreHome()
      ..read<LiveSocketCubit>().initSocket()
      ..read<PageCubit>().handleRoute()
      ..read<GiftShopCubit>().fetchGiftShopList();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      isLoading: context.select((AuthBloc bloc) => bloc.state.isLoading),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              40.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(vertical: 42.h),
                child: Image.asset(
                  AppAsset.images.logo.path,
                  width: 100.sp,
                ),
              ),
              AppText(
                context.text.login,
                style: AppStyle.text22.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  context.text.phone,
                  style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              4.verticalSpace,
              DTextField(
                controller: phoneController,
                hint: context.text.phone,
                type: DTextInputType.phone,
                prefix: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: AppText(
                          '+84',
                          style: AppStyle.text14.copyWith(color: Color(0xFF000000), fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        height: 20.h,
                        color: Color(0xFFACACAC),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  context.text.password,
                  style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              4.verticalSpace,
              DTextField(
                controller: passwordController,
                hint: context.text.password,
                type: DTextInputType.password,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AppText(
                  "${context.text.forgotPassword}?",
                  onTap: () => DNavigator.goNamed(RouteNamed.forgotPassword),
                  style: AppStyle.text14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFF48321),
                  ),
                ),
              ),
              10.verticalSpace,
              GradientButton(
                text: context.text.login,
                onPressed: () {
                  if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
                    DMessage.showMessage(message: context.text.pleaseFillAllFields);
                    return;
                  }

                  context.read<AuthBloc>().add(LoginEvent(
                        phone: phoneController.text,
                        password: passwordController.text,
                        onSuccess: loginSuccess,
                      ));
                },
                gradient: LinearGradient(
                  colors: AppCustomColor.gradientButton,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.2, 0.4, 0.55, 0.7, 0.97],
                ),
              ),
              12.verticalSpace,
              if (kDebugMode) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(height: 1.h)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15).w,
                      child: AppText(
                        context.text.or,
                        style: AppStyle.text14.copyWith(
                          color: Color(0xFFACACAC),
                        ),
                      ),
                    ),
                    Expanded(child: Divider(height: 1.h)),
                  ],
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () => context.read<AuthBloc>().add(LoginZaloEvent(onSuccess: loginSuccess)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAsset.icons.zalo.path, width: 28.w),
                      15.horizontalSpace,
                      AppText('Zalo', style: AppStyle.text16),
                    ],
                  ),
                ),
              ],
              110.verticalSpace,
              AppText(
                context.text.policyAndTerms,
                onTap: () => showTermOfUseApp(context),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppStyle.text10,
              ),
              4.verticalSpace,
              InkWell(
                onTap: () {
                  DNavigator.goNamed(RouteNamed.register);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(AppLocalizations.of(context).doNotHaveAccount, style: AppStyle.text14),
                    4.horizontalSpace,
                    AppText(
                      AppLocalizations.of(context).register,
                      style: AppStyle.text14.copyWith(
                        color: Color(0xFFE86423),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

void showTermOfUseApp(BuildContext context) {
  showDataBottomSheet(
    title: context.text.policy,
    maxChildSize: 0.7,
    body: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 14).w,
        child: BlocBuilder<ConfigCubit, ConfigState>(
          builder: (context, state) => HtmlWidget(state.termsOfUseApp),
        ),
      ),
      20.verticalSpace,
    ],
  );
}
