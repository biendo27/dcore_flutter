part of '../../setting.dart';

class AffiliateRegisterPage extends StatefulWidget {
  const AffiliateRegisterPage({super.key});

  @override
  State<AffiliateRegisterPage> createState() => _AffiliateRegisterPageState();
}

class _AffiliateRegisterPageState extends State<AffiliateRegisterPage> {
  late bool isRegisterd;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController specificAddressController = TextEditingController();
  TextEditingController cccdController = TextEditingController();
  TextEditingController taxCodeController = TextEditingController();
  File? frontPhoto;
  File? backPhoto;

  @override
  void initState() {
    isRegisterd = context.read<UserCubit>().state.user.isAffiliate;

    final cubit = context.read<AffiliateCubit>();
    cubit.fetchNationList();

    if(cubit.state.affiliateInfo.id != 0 && isRegisterd) {
      fullNameController.text = cubit.state.affiliateInfo.name;
      phoneController.text = cubit.state.affiliateInfo.phone;
      emailController.text = cubit.state.affiliateInfo.email;
      specificAddressController.text = cubit.state.affiliateInfo.address;
    }
    super.initState();
  }

  Future<void> onTakePicture({required bool isFrontPhoto}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      isFrontPhoto
          ? frontPhoto = File(pickedFile.path)
          : backPhoto = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.affiliateProfile,
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<AffiliateCubit, AffiliateState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('${context.text.fullName} *', style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  4.verticalSpace,
                  DTextField(
                    controller: fullNameController,
                    hint: context.text.fullName,
                  ),
                  AppText('${context.text.phone} *', style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  4.verticalSpace,
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
                  ),
                  AppText('${context.text.email} *', style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  4.verticalSpace,
                  DTextField(
                      controller: emailController,
                      hint: context.text.email,
                      type: DTextInputType.email
                  ),
                  AppText('${context.text.addressInformation} *', style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  4.verticalSpace,
                  BlocBuilder<AffiliateCubit, AffiliateState>(
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
                          context.read<AffiliateCubit>()
                            ..setSelectedNation(value)
                            ..fetchCityList();
                        },
                      );
                    },
                  ),
                  BlocBuilder<AffiliateCubit, AffiliateState>(
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
                          context.read<AffiliateCubit>()
                            ..setSelectedCity(value)
                            ..fetchDistrictList();
                        },
                      );
                    },
                  ),
                  BlocBuilder<AffiliateCubit, AffiliateState>(
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
                          context.read<AffiliateCubit>()
                            ..setSelectedDistrict(value)
                            ..fetchWardList();
                        },
                      );
                    },
                  ),
                  BlocBuilder<AffiliateCubit, AffiliateState>(
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
                          context.read<AffiliateCubit>()
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
                  ),
                  10.verticalSpace,
                  if (!isRegisterd) ...[
                    // CCCD/CMND
                    AppText("CCCD/CMND *", style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                    10.verticalSpace,
                    DTextField(
                      hint: "CCCD/CMND",
                      controller: cccdController,
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () => onTakePicture(isFrontPhoto: true),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText("${context.text.frontImage} *", style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                                10.verticalSpace,
                                frontPhoto != null ? Image.file(
                                  frontPhoto!,
                                  height: 100.w,
                                  width: 200.w,
                                  fit: BoxFit.cover,
                                ) : Container(
                                  width: 200.w,
                                  height: 100.w,
                                  decoration: BoxDecoration(
                                    color: AppCustomColor.greyE9,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 40.w,
                                    color: AppCustomColor.greyAC,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        15.horizontalSpace,
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () => onTakePicture(isFrontPhoto: false),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText("${context.text.backImage} *", style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                                10.verticalSpace,
                                backPhoto != null ? Image.file(
                                  backPhoto!,
                                  height: 100.w,
                                  width: 200.w,
                                  fit: BoxFit.cover,
                                ) : Container(
                                  width: 200.w,
                                  height: 100.w,
                                  decoration: BoxDecoration(
                                    color: AppCustomColor.greyE9,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 40.w,
                                    color: AppCustomColor.greyAC,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    AppText(context.text.taxCode, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                    10.verticalSpace,
                    DTextField(
                      hint: "0220838383",
                      controller: taxCodeController,
                    ),
                    10.verticalSpace,
                  ],
                  GradientButton(
                      text: context.text.send,
                      onPressed: () => onSubmit(state)
                  ),
                  20.verticalSpace,
                ],
              ),
            );
          }
      ),
    );
  }

  void onSubmit(AffiliateState state) {
    if(!isRegisterd) {
      validateInput(state);

      context.read<AffiliateCubit>().affiliateRegister(
          fullNameController.text,
          phoneController.text,
          emailController.text,
          specificAddressController.text,
          cccdController.text,
          taxCodeController.text,
          frontPhoto!,
          backPhoto!
      );
    } else {
      context.read<AffiliateCubit>().affiliateUpdate(
        fullNameController.text,
        phoneController.text,
        emailController.text,
        specificAddressController.text,
      );
    }
  }

  void validateInput(AffiliateState state) {
    if(fullNameController.text.isEmpty) {
      DMessage.showMessage(message: "Vui lòng nhập Họ và tên", type: MessageType.error);
      return;
    }

    if(phoneController.text.isEmpty) {
      DMessage.showMessage(message: "Vui lòng nhập Số điện thoại", type: MessageType.error);
      return;
    }

    if(emailController.text.isEmpty) {
      DMessage.showMessage(message: "Vui lòng nhập email", type: MessageType.error);
      return;
    }

    if(state.selectedNation == null) {
      DMessage.showMessage(message: "Vui lòng chọn Quốc gia", type: MessageType.error);
      return;
    }

    if(state.selectedCity == null) {
      DMessage.showMessage(message: "Vui lòng chọn Thành phố", type: MessageType.error);
      return;
    }

    if(state.selectedDistrict == null) {
      DMessage.showMessage(message: "Vui lòng chọn Quận huyện", type: MessageType.error);
      return;
    }

    if(state.selectedWard == null) {
      DMessage.showMessage(message: "Vui lòng chọn Phường xã", type: MessageType.error);
      return;
    }

    if(specificAddressController.text.isEmpty) {
      DMessage.showMessage(message: "Vui lòng nhập địa chỉ", type: MessageType.error);
      return;
    }

    if(cccdController.text.isEmpty) {
      DMessage.showMessage(message: "Vui lòng nhập số cccd", type: MessageType.error);
      return;
    }

    if(frontPhoto == null || backPhoto == null) {
      DMessage.showMessage(message: "Vui lòng chụp ảnh giấy tờ", type: MessageType.error);
      return;
    }

    if(taxCodeController.text.isEmpty) {
      DMessage.showMessage(message: "Vui lòng nhập mã số thuế", type: MessageType.error);
      return;
    }
  }

  @override
  void dispose() {
    if(!isRegisterd) AppConfig.context!.read<AffiliateCubit>().resetAddress();
    super.dispose();
  }
}