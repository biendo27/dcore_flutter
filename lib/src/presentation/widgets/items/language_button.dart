part of '../widgets.dart';

class LanguageBtn extends StatelessWidget {
  final LocaleType locale;

  const LanguageBtn({
    super.key,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<LocaleCubit>().changeLocale(locale),
      child: BlocBuilder<LocaleCubit, LocaleType>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12).w,
            decoration: BoxDecoration(
              color: state.localeData == locale.localeData ? AppTheme.primaryColor : AppTheme.onPrimary,
              borderRadius: BorderRadius.circular(8.sp),
              border: Border.all(color: AppTheme.primaryColor, width: 1),
            ),
            child: AppText(
              locale.value.capilitize,
            ),
          );
        },
      ),
    );
  }
}
