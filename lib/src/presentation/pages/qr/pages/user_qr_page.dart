part of '../qr.dart';

class UserQRPage extends StatefulWidget {
  const UserQRPage({super.key});

  @override
  State<UserQRPage> createState() => _UserQRPageState();
}

class _UserQRPageState extends State<UserQRPage> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.share,
      body: Column(
        children: [
          20.verticalSpace,
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Screenshot(
                controller: screenshotController,
                child: QrView(user: state.user),
              );
            },
          ),
          20.verticalSpace,
          Row(
            children: [
              20.horizontalSpace,
              GradientButton(
                onPressed: () => DNavigator.goNamed(RouteNamed.qrScanner),
                text: context.text.scanQR,
                expandedFlex: 1,
                buttonType: DButtonType.outline,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                customChild: GradientTypography(
                  gradient: LinearGradient(colors: AppCustomColor.gradientButton),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner_rounded, size: 18.w),
                      8.horizontalSpace,
                      Text(context.text.scanQR, style: AppStyle.textBold16),
                    ],
                  ),
                ),
              ),
              12.horizontalSpace,
              GradientButton(
                onPressed: () async {
                  try {
                    await StorageService.captureAndSaveWidget(
                      screenshotController,
                      pixelRatio: MediaQuery.devicePixelRatioOf(context),
                    );
                    if (!context.mounted) return;
                    DMessage.showMessage(message: context.text.savedImageSuccess);
                  } catch (e) {
                    if (!mounted) return;
                    DMessage.showMessage(message: context.text.savedImageFailed);
                  }
                },
                text: context.text.savedImage,
                expandedFlex: 1,
                buttonType: DButtonType.outline,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                customChild: GradientTypography(
                  gradient: LinearGradient(colors: AppCustomColor.gradientButton),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 18.w),
                      8.horizontalSpace,
                      Text(context.text.savedImage, style: AppStyle.textBold16),
                    ],
                  ),
                ),
              ),
              20.horizontalSpace,
            ],
          ),
          20.verticalSpace,
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20).w,
            child: Row(
              children: [
                GradientButton(
                  onPressed: DNotiMessage.featureInDevelopment,
                  buttonType: DButtonType.outline,
                  expandedFlex: 1,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  customChild: GradientTypography(
                    gradient: LinearGradient(colors: AppCustomColor.gradientButton),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.text.copy, style: AppStyle.textBold16),
                        8.horizontalSpace,
                        Icon(Icons.copy, size: 18.w),
                      ],
                    ),
                  ),
                ),
                12.horizontalSpace,
                GradientButton(
                  onPressed: () async {
                    try {
                      await StorageService.shareWidget(
                        screenshotController,
                        pixelRatio: MediaQuery.devicePixelRatioOf(context),
                        fileName: 'vns_qr_code_${DateTime.now().millisecondsSinceEpoch}.png',
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      DMessage.showMessage(message: context.text.shareFailed);
                    }
                  },
                  expandedFlex: 1,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  customChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(context.text.share, style: AppStyle.textBold16.copyWith(color: AppColorLight.onPrimary)),
                      8.horizontalSpace,
                      Icon(Icons.share, color: AppColorLight.onPrimary, size: 18.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
