part of '../wallet.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.contact,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: BlocBuilder<ConfigCubit, ConfigState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  context.text.unit,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w700),
                ),
                4.verticalSpace,
                AppText(
                  state.contact.company,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                10.verticalSpace,
                AppText(
                  context.text.headquarters,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w700),
                ),
                4.verticalSpace,
                AppText(
                  state.contact.address,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                10.verticalSpace,
                AppText(
                  "Website",
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w700),
                ),
                4.verticalSpace,
                AppText(
                  state.contact.website,
                  onTap: () => launchUrlString('https://${state.contact.website}'),
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                10.verticalSpace,
                AppText(
                  "Hotline - Zalo",
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w700),
                ),
                4.verticalSpace,
                AppText(
                  state.contact.hotline,
                  onTap: () => launchUrlString('tel:${state.contact.hotline.replaceAll('.', '')}'),
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                10.verticalSpace,
                AppText(
                  "Email",
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w700),
                ),
                4.verticalSpace,
                AppText(
                  state.contact.email,
                  onTap: () => launchUrlString('mailto:${state.contact.email}'),
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                10.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}
