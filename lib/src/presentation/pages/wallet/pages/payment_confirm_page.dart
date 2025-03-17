part of '../wallet.dart';

class PaymentConfirmPage extends StatefulWidget {
  final int id;
  const PaymentConfirmPage({super.key, required this.id});

  @override
  State<PaymentConfirmPage> createState() => _PaymentConfirmPageState();
}

class _PaymentConfirmPageState extends State<PaymentConfirmPage> {
  File? picture;

  @override
  void initState() {
    context.read<WalletCubit>().walletBanking(widget.id);
    super.initState();
  }

  Future<void> onTakePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      picture = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
        title: "Thanh toán",
        backgroundColor: Color(0xfff3f3f3),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
          child: Column(
            children: [
              BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
                final bank = state.banks;
                return Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _transferInformation(bank),
                      20.verticalSpace,
                      _transferSyntax(bank),
                      20.verticalSpace,
                      _takePicture(),
                    ],
                  ),
                ));
              }),
              10.verticalSpace,
              GradientButton(
                onPressed: () {
                  if (picture != null) {
                    context.read<WalletCubit>().walletUploadDeposit(picture!, widget.id);
                  }
                },
                text: "Hoàn tất",
              )
            ],
          ),
        ));
  }

  Widget _transferInformation(Banking bank) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              AppAsset.images.banking.path,
              width: 24.sp,
              height: 24.sp,
              color: Colors.red,
            ),
            10.horizontalSpace,
            AppText(
              "Thông tin chuyển khoản",
              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        10.verticalSpace,
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(border: Border.all(color: AppCustomColor.orangeF1, width: 1), borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
          child: Column(
            children: [
              DCachedImage(
                url: bank.qr,
                width: 150.sp,
                height: 150.sp,
              ),
              8.verticalSpace,
              AppText(
                "Tên chủ TK: ${bank.bankOwner}",
                style: AppStyle.text12.copyWith(color: Color(0xff2D2D2D)),
              ),
              10.verticalSpace,
              AppText("STK: ${bank.bankNumber}", style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600)),
              AppText("Ngân hàng: ${bank.bankName}", style: AppStyle.text12.copyWith(color: Color(0xff2D2D2D))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _transferSyntax(Banking bank) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              AppAsset.images.banking.path,
              width: 24.sp,
              height: 24.sp,
              color: Colors.orange,
            ),
            10.horizontalSpace,
            AppText(
              "Cú pháp chuyển khoản",
              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        10.verticalSpace,
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
          child: Row(
            children: [
              Expanded(child: AppText(bank.note, style: AppStyle.text14)),
              10.horizontalSpace,
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: bank.note));
                },
                child: Container(
                  padding: EdgeInsets.all(4.sp),
                  decoration: BoxDecoration(color: Colors.grey.op(0.5), borderRadius: BorderRadius.circular(30.sp)),
                  child: Icon(Icons.copy, size: 16.sp),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _takePicture() {
    return Column(
      children: [
        Row(
          children: [
            2.horizontalSpace,
            Image.asset(
              AppAsset.images.uploadImage.path,
              width: 20.sp,
              height: 20.sp,
              fit: BoxFit.cover,
            ),
            10.horizontalSpace,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context.text.uploadImage,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: " *",
                    style: TextStyle(fontSize: 14.sp, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
        10.verticalSpace,
        DButton(
          onPressed: onTakePicture,
          backgroundColor: Colors.grey.op(0.3),
          customChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.grey,
              ),
              8.horizontalSpace,
              AppText("Chọn ảnh", style: AppStyle.text12)
            ],
          ),
        ),
        picture != null
            ? Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Image.file(
                  picture!,
                  width: MediaQuery.of(context).size.width,
                  height: 400.sp,
                  fit: BoxFit.cover,
                ))
            : AppText(
                "Lưu ý: Người dùng sau khi thanh toán thành công sẽ gửi ảnh chụp màn hình chuyển khoản để chúng tôi xác nhận thông tin",
                style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                maxLines: 3,
              ),
      ],
    );
  }
}
