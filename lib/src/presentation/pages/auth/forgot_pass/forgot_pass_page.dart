part of '../auth.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.forgotPassword,
      isLoading: context.select((AuthBloc bloc) => bloc.state.isLoading),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(context.text.enterPhoneNumber, maxLines: 2, style: AppStyle.text14),
              20.verticalSpace,
              AppText(context.text.phone, style: AppStyle.text12),
              10.verticalSpace,
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
                          style: AppStyle.text14.copyWith(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(width: 1.w, height: 20.h, color: Color(0xFFACACAC)),
                    ],
                  ),
                ),
              ),
              25.verticalSpace,
              GradientButton(
                text: context.text.continueText,
                style: AppStyle.text20.copyWith(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w400,
                ),
                onPressed: () {
                  if (phoneController.text.isEmpty) {
                    DMessage.showMessage(message: context.text.pleaseFillAllFields);
                    return;
                  }
                  context.read<AuthBloc>().add(ForgotPasswordEvent(phone: phoneController.text));
                },
                gradient: LinearGradient(colors: AppCustomColor.gradientButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
