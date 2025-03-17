part of '../../shop.dart';

class BankAccountRefundPage extends StatefulWidget {
  const BankAccountRefundPage({super.key});

  @override
  State<BankAccountRefundPage> createState() => _BankAccountRefundPageState();
}

class _BankAccountRefundPageState extends State<BankAccountRefundPage> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void _viewPolicy() {
    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: PrivacyBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.bankAccountRefund,
      isLoading: context.select((RefundBankingCubit bloc) => bloc.state.isLoading),
      resizeToAvoidBottomInset: true,
      body: BlocListener<RefundBankingCubit, RefundBankingState>(
        listener: (context, state) {
          if (bankNameController.text.isEmpty) {
            bankNameController.text = state.refundBanking.bankOwner;
          }

          if (bankAccountNumberController.text.isEmpty) {
            bankAccountNumberController.text = state.refundBanking.bankNumber;
          }

          if (phoneController.text.isEmpty) {
            phoneController.text = state.refundBanking.phone;
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        context.text.contactInformation,
                        style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                      ),
                      16.verticalSpace,
                      AppText(
                        context.text.bankAccountHolder,
                        style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                      ),
                      8.verticalSpace,
                      DTextField(
                        controller: bankNameController,
                        hint: context.text.bankAccountHolder,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                      ),
                      AppText(
                        context.text.bankAccountNumber,
                        style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                      ),
                      8.verticalSpace,
                      BlocBuilder<RefundBankingCubit, RefundBankingState>(
                        builder: (context, state) {
                          return SelectSearchButton(
                            onChanged: (value) => context.read<RefundBankingCubit>().setSelectedBank(value),
                            items: state.listBankData.map((e) => DropdownItem(value: e, label: e.name)).toList(),
                            selectedValue: state.selectedBank,
                            hint: context.text.chooseBank,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                          );
                        },
                      ),
                      8.verticalSpace,
                      AppText(
                        context.text.bankAccountNumber,
                        style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                      ),
                      8.verticalSpace,
                      DTextField(
                        controller: bankAccountNumberController,
                        hint: context.text.bankAccountNumber,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                      ),
                      // phone
                      16.verticalSpace,
                      AppText(
                        context.text.phone,
                        style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                      ),
                      8.verticalSpace,
                      DTextField(
                        controller: phoneController,
                        hint: context.text.phone,
                        type: DTextInputType.phone,
                        prefix: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: AppText(
                                  '+84',
                                  style: AppStyle.text14.copyWith(color: Color(0xFF000000), fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                width: 1.w,
                                height: 20.h,
                                color: Color(0xFFACACAC),
                              ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      ),
                    ],
                  ),
                ),
              ),
              16.verticalSpace,
              GestureDetector(
                onTap: () => _viewPolicy(),
                child: DHighlightText(
                  text: context.text.saveAndAgreeWithPrivacyPolicy,
                  highlights: [context.text.ourPrivacyPolicy],
                  style: AppStyle.text10.copyWith(fontWeight: FontWeight.w300),
                  highlightStyles: [AppStyle.text10.copyWith(fontWeight: FontWeight.w500)],
                ),
              ),
              10.verticalSpace,
              GradientButton(
                text: context.text.save,
                onPressed: () {
                  context.read<RefundBankingCubit>().updateRefundBanking(
                        RefundBanking(
                          bankOwner: bankNameController.text,
                          bankNumber: bankAccountNumberController.text,
                          phone: phoneController.text,
                        ),
                      );
                },
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
