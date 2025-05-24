part of '../qr.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> with WidgetsBindingObserver {
  MobileScannerController controller = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      CameraService.requestCameraPermission();
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(controller.stop());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture event) {
    final List<Barcode> barcodes = event.barcodes;
    for (final barcode in barcodes) {
      try {
        final AppUser user = AppUser.fromJson(jsonDecode(barcode.rawValue!));
        if (user.id == 0) continue;
        context.read<ProfilePreviewCubit>().setCurrentUser(user);
        DNavigator.replaceNamed(RouteNamed.profilePreview);
        break;
      } catch (e) {
        DMessage.showMessage(message: context.text.invalidQRCode);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.scanQR,
      body: Column(
        children: [
          20.verticalSpace,
          // QR Scanner Container with gradient border
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                colors: AppCustomColor.gradientContainer,
              ),
            ),
            child: Container(
              height: (1.sw - 20).w,
              width: (1.sw - 20).w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19.r),
                child: MobileScanner(
                  controller: controller,
                  onDetect: _handleBarcode,
                ),
              ),
            ),
          ),
          20.verticalSpace,
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              20.horizontalSpace,
              GradientButton(
                onPressed: DNavigator.back,
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
                      Text(context.text.myQR, style: AppStyle.textBold16),
                      8.horizontalSpace,
                      Icon(Icons.qr_code_rounded, size: 18.w),
                    ],
                  ),
                ),
              ),
              12.horizontalSpace,
              GradientButton(
                onPressed: () async {
                  try {
                    // Use MediaHelper to pick image
                    final File? pickedImage = await MediaService.pickImage();

                    if (pickedImage == null) {
                      if (!context.mounted) return;
                      DMessage.showMessage(message: context.text.imagePickFailed);
                      return;
                    }

                    // Analyze the image for QR codes
                    final BarcodeCapture? captureResult = await controller.analyzeImage(pickedImage.path);

                    if (captureResult == null || captureResult.barcodes.isEmpty) {
                      if (!context.mounted) return;
                      DMessage.showMessage(message: context.text.noQRCodeFound);
                      return;
                    }

                    // Handle the first valid QR code found
                    _handleBarcode(captureResult);
                  } catch (e) {
                    if (!context.mounted) return;
                    DMessage.showMessage(message: context.text.qrScanFailed);
                  }
                },
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
                      Text(context.text.chooseImage, style: AppStyle.textBold16),
                      8.horizontalSpace,
                      Icon(Icons.image, size: 18.w),
                    ],
                  ),
                ),
              ),
              20.horizontalSpace,
            ],
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
