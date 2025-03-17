part of '../auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.changePassword,
      isLoading: context.select((AuthBloc bloc) => bloc.state.isLoading),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(context.text.password, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
              DTextField(
                controller: _oldPasswordController,
                type: DTextInputType.password,
                hint: AppConfig.context!.text.inputPassword,
              ),
              AppText(context.text.inputNewPassword, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
              DTextField(
                hint: AppConfig.context!.text.inputNewPassword,
                controller: _newPasswordController,
                type: DTextInputType.password,
              ),
              AppText(context.text.inputConfirmPassword, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
              DTextField(
                hint: AppConfig.context!.text.inputConfirmPassword,
                controller: _confirmPasswordController,
                type: DTextInputType.password,
              ),
              20.verticalSpace,
              GradientButton(
                text: context.text.changePassword,
                onPressed: () {
                  context.read<AuthBloc>().add(ChangePasswordEvent(
                        oldPassword: _oldPasswordController.text,
                        newPassword: _newPasswordController.text,
                        confirmPassword: _confirmPasswordController.text,
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
