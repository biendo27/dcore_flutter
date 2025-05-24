part of '../auth.dart';

class SetupPassPage extends StatefulWidget {
  const SetupPassPage({super.key});

  @override
  State<SetupPassPage> createState() => _SetupPassPageState();
}

class _SetupPassPageState extends State<SetupPassPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.resetPasswordAccount,
      isLoading: context.select((AuthBloc bloc) => bloc.state.isLoading),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                context.text.password,
                style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            10.verticalSpace,
            DTextField(
              controller: passwordController,
              hint: context.text.password,
              type: DTextInputType.password,
            ),
            AppText(context.text.inputConfirmPassword, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            10.verticalSpace,
            DTextField(
              controller: confirmPasswordController,
              hint: context.text.inputConfirmPassword,
              type: DTextInputType.password,
            ),
            10.verticalSpace,
            GradientButton(
                text: context.text.continueText,
                onPressed: () {
                  context.read<AuthBloc>().add(ResetPasswordEvent(
                        password: passwordController.text,
                        passwordConfirm: confirmPasswordController.text,
                      ));
                })
          ]),
        ),
      ),
    );
  }
}
