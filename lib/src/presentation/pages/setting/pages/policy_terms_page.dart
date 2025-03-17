part of '../setting.dart';

class PolicyTermsPage extends StatelessWidget {
  const PolicyTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
        title: context.text.termsOfUse,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ConfigCubit, ConfigState>(
                builder: (context, state) => HtmlWidget(state.termsOfUseApp),
              ),
            ],
          ),
        ));
  }
}
