part of '../../shop.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  ValueNotifier<bool> isSendMail = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      onBackSuccess: () => context.read<LiveCubit>().setCurrentLive(Live()),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.verticalSpace,
            Image.asset(
              AppAsset.images.paymentSuccess.path,
              width: 150.w,
              height: 150.w,
            ),
            24.verticalSpace,
            AppText(
              context.text.paymentSuccess,
              style: AppStyle.text16.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            20.verticalSpace,
            AppText(
              context.text.paymentSuccessMessage,
              style: AppStyle.text14,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            20.verticalSpace,
            DButton(
              onPressed: () {
                DNavigator.back();
                context.read<LiveCubit>().setCurrentLive(Live());
              },
              text: context.text.backToHome,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
              backgroundColor: AppCustomColor.greyF5,
              style: AppStyle.text14.copyWith(
                color: AppColorLight.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(context.text.sendEmail, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w600)),
                ValueListenableBuilder(
                    valueListenable: isSendMail,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: value,
                          onChanged: (_) => isSendMail.value = !isSendMail.value,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      );
                    }),
              ],
            ),
            10.verticalSpace,
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return AppText(
                  context.text.sendEmailMessage(limitEmail(state.user.email)),
                  style: AppStyle.text14,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                );
              },
            ),
            // OtherProducts(),
          ],
        ),
      ),
    );
  }

  String limitEmail(String email) {
    if (email.isEmpty) return "";
    final List<String> emailParts = email.split("@");
    if (emailParts.length < 2) return email;
    final String emailName = emailParts[0];
    final String emailDomain = emailParts[1];
    final String emailNameLimit = emailName.substring(0, min(3, emailName.length));
    return "$emailNameLimit***@$emailDomain";
  }
}
