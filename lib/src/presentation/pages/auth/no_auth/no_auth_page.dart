part of '../auth.dart';

class NoAuthPage extends StatefulWidget {
  const NoAuthPage({super.key});

  @override
  State<NoAuthPage> createState() => _NoAuthPageState();
}

class _NoAuthPageState extends State<NoAuthPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.loginRegister,
      body: Column(
        children: [
          50.verticalSpace,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.w),
              child: Image.asset(
                AppAsset.images.noAuth.path,
                height: 348.h,
                width: 348.w,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 30.h, left: 27.w, right: 27.w),
            width: 1.sw,
            height: 225.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppCustomColor.gradientBackground,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.22, 0.47, 0.78, 0.96],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(
                  context.text.loginMessage,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: AppStyle.text16.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                30.verticalSpace,
                DButton(
                  onPressed: () => DNavigator.replaceNamed(RouteNamed.login),
                  text: context.text.continueText,
                  backgroundColor: AppColorLight.surface,
                  style: AppStyle.text14.copyWith(color: AppCustomColor.orangeF4, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
