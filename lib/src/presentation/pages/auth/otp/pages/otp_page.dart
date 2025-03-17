part of '../../auth.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();
  CountDownController countDownController = CountDownController(
    initialCountdown: 60,
    onStartCount: () => LogDev.warning('Countdown started'),
    onEndCount: () => LogDev.warning('Countdown ended'),
  );

  @override
  void initState() {
    super.initState();
    countDownController.start();
  }

  @override
  void dispose() {
    countDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.verifyAccount,
      isLoading: context.select((AuthBloc bloc) => bloc.state.isLoading),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.horizontalSpace,
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return DHighlightText(
                    text: '${context.text.inputOtpSendToNumber} ${state.phone}',
                    maxLines: 2,
                    highlights: [state.phone],
                    highlightStyles: [
                      AppStyle.text14.copyWith(fontWeight: FontWeight.w600, color: AppCustomColor.orangeF4),
                    ],
                    style: AppStyle.text14,
                  );
                },
              ),
              28.verticalSpace,
              PinCodeTextField(
                controller: otpController,
                appContext: context,
                length: 6,
                obscureText: false,
                cursorColor: AppColorLight.primary,
                animationType: AnimationType.fade,
                autoDisposeControllers: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  activeColor: AppColorLight.outlineVariant,
                  inactiveColor: AppColorLight.outlineVariant,
                  selectedColor: AppColorLight.primary,
                  fieldHeight: 44.h,
                  fieldWidth: 44.w,
                  borderWidth: 2.w,
                  activeFillColor: AppColorLight.surfaceContainerHighest,
                  inactiveFillColor: AppColorLight.surfaceContainerHighest,
                  selectedFillColor: AppColorLight.surfaceContainerHighest,
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(
                    onTap: () {
                      if (countDownController.countdownNotifier.value != 0) return;

                      context.read<AuthBloc>().add(ResendOTPEvent());
                      countDownController.resetTimer();
                    },
                    context.text.resendCode,
                    style: AppStyle.text14,
                  ),
                  Spacer(),
                  CountdownTimerWidget(
                    countdownController: countDownController,
                    style: AppStyle.text14,
                  ),
                ],
              ),
              28.verticalSpace,
              GradientButton(
                text: context.text.verify,
                onPressed: () {
                  if (otpController.text.isEmpty) {
                    DMessage.showMessage(type: MessageType.error, message: context.text.pleaseEnterOTP);
                    return;
                  }

                  context.read<AuthBloc>().add(VerifyOTPEvent(otp: otpController.text));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
