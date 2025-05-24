part of '../setting.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SubLayout(
        title: context.text.selectLanguage,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                key: _menuKey,
                onTap: () => _showLanguageMenu(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      AppText(
                        context.text.selectLanguage,
                        style: AppStyle.text14.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      BlocBuilder<LocaleCubit, LocaleType>(
                        builder: (context, state) {
                          return AppText(
                            state.label,
                            style: AppStyle.text12.copyWith(color: AppCustomColor.greyAC),
                          );
                        },
                      ),
                      4.horizontalSpace,
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15.sp,
                      )
                    ],
                  ),
                ),
              ),
              6.verticalSpace,
              AppText(
                context.text.appDefaultLanguagePrompt,
                style: AppStyle.text12.copyWith(color: AppCustomColor.greyC4),
              )
            ],
          ),
        ));
  }

  Future<void> _showLanguageMenu(BuildContext context) async {
    final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final screenWidth = 1.sw;

    LocaleType? localeType = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        screenWidth - position.dx,
        position.dy + renderBox.size.height,
        10,
        0,
      ),
      items: LocaleType.values.map((e) => PopupMenuItem(value: e, child: AppText(e.label, style: AppStyle.text16))).toList(),
    );

    if (localeType != null) {
      _changeLanguage(localeType);
    }
  }

  void _changeLanguage(LocaleType localeType) {
    context.read<ProfileCubit>().updateLanguage(localeType.value);
    context.read<LocaleCubit>().changeLocale(localeType);
  }
}
