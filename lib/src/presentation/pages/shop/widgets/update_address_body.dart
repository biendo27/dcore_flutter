part of '../shop.dart';

class UpdateAddressBody extends StatelessWidget {
  final String title;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController specificAddressController;
  final ValueNotifier<bool> isDefault;
  final void Function() onSave;

  const UpdateAddressBody({
    super.key,
    this.title = '',
    required this.nameController,
    required this.phoneController,
    required this.specificAddressController,
    required this.isDefault,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: title,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(context.text.contactInformation, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                    10.verticalSpace,
                    AppText(context.text.fullName, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
                    DTextField(
                      hint: context.text.fullName,
                      controller: nameController,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                    ),
                    AppText(context.text.phone, style: AppStyle.text12),
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
                    10.verticalSpace,
                    AppText(context.text.addressInformation, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                    8.verticalSpace,
                    BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
                      builder: (context, state) {
                        return DDropDownButton(
                          hint: "-- Quốc gia --",
                          items: state.nations
                              .map((e) => DropdownItem(
                                    value: e,
                                    label: e.name,
                                  ))
                              .toList(),
                          hintStyle: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                          selectedValue: state.selectedNation,
                          onChanged: (value) {
                            context.read<DeliveryAddressCubit>()
                              ..setSelectedNation(value)
                              ..fetchCityList();
                          },
                        );
                      },
                    ),
                    BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
                      builder: (context, state) {
                        return DDropDownButton(
                          hint: "-- Thành phố --",
                          items: state.cities
                              .map((e) => DropdownItem(
                                    value: e,
                                    label: e.name,
                                  ))
                              .toList(),
                          hintStyle: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                          selectedValue: state.selectedCity,
                          onChanged: (value) {
                            context.read<DeliveryAddressCubit>()
                              ..setSelectedCity(value)
                              ..fetchDistrictList();
                          },
                        );
                      },
                    ),
                    BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
                      builder: (context, state) {
                        return DDropDownButton(
                          hint: "-- Quận huyện --",
                          items: state.districts
                              .map((e) => DropdownItem(
                                    value: e,
                                    label: e.name,
                                  ))
                              .toList(),
                          hintStyle: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                          selectedValue: state.selectedDistrict,
                          onChanged: (value) {
                            context.read<DeliveryAddressCubit>()
                              ..setSelectedDistrict(value)
                              ..fetchWardList();
                          },
                        );
                      },
                    ),
                    BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
                      builder: (context, state) {
                        return DDropDownButton(
                          hint: "-- Phường xã --",
                          items: state.wards
                              .map((e) => DropdownItem(
                                    value: e,
                                    label: e.name,
                                  ))
                              .toList(),  
                          hintStyle: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                          selectedValue: state.selectedWard,
                          onChanged: (value) {
                            context.read<DeliveryAddressCubit>()
                              ..setSelectedWard(value)
                              ..fetchWardList();
                          },
                        );
                      },
                    ),
                    10.verticalSpace,
                    AppText(context.text.specificAddress, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                    10.verticalSpace,
                    DTextField(
                      controller: specificAddressController,
                      hint: context.text.specificAddress,
                      type: DTextInputType.multiline,
                      maxLines: 3,
                    )
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            AppText(
              context.text.setting,
              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  context.text.setDefaultAddress,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                ValueListenableBuilder(
                  valueListenable: isDefault,
                  builder: (context, value, child) => Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isDefault.value,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (value) => isDefault.value = value,
                    ),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: _viewPolicy,
              child: Center(
                child: DHighlightText(
                  text: context.text.saveAndAgreeWithPrivacyPolicy,
                  highlights: [context.text.ourPrivacyPolicy],
                  style: AppStyle.text10.copyWith(fontWeight: FontWeight.w300),
                  highlightStyles: [AppStyle.text10.copyWith(fontWeight: FontWeight.w500)],
                ),
              ),
            ),
            10.verticalSpace,
            GradientButton(onPressed: onSave, text: context.text.save),
          ],
        ),
      ),
    );
  }

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
}
