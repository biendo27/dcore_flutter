part of '../profile.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({super.key});

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();

  Future<void> _pickAvatar() async {
    bool hasPermission = await MediaService.requestMediaPermission();
    if (!hasPermission) return;

    final pickedImage = await MediaService.pickImage();
    if (pickedImage == null) return;
    if (!mounted) return;
    context.read<ProfileCubit>().setAvatar(pickedImage.path);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppUser user = context.read<UserCubit>().state.user;
      phoneController.text = user.phone;
      emailController.text = user.email;
      fullNameController.text = user.name;
      usernameController.text = user.username;
      birthDayController.text = user.birthday?.toLocalDateString ?? '';
      bioController.text = user.bio;
      facebookController.text = user.facebookUrl;
      instagramController.text = user.instagramUrl;
      youtubeController.text = user.youtubeUrl;
    });
    super.initState();
  }

  String _avatar(String avtFilePath) {
    if (avtFilePath.isEmpty) {
      AppUser user = context.read<UserCubit>().state.user;
      return user.avatarUrl;
    }
    return avtFilePath;
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.editProfilePage,
      isLoading: context.select((ProfileCubit bloc) => bloc.state.isLoading),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return DCircleAvatar(
                    url: _avatar(state.avatar),
                    radius: 64,
                    onSubActionTap: _pickAvatar,
                    subAction: Icon(FontAwesomeIcons.camera, size: 16, color: AppColorLight.primary),
                  );
                },
              ),
            ),
            10.verticalSpace,
            AppText(context.text.phone, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            4.verticalSpace,
            DTextField(
              controller: phoneController,
              hint: context.text.phone,
              type: DTextInputType.phone,
              readOnly: true,
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
            5.verticalSpace,
            AppText(context.text.email, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            4.verticalSpace,
            DTextField(
              controller: emailController,
              hint: context.text.email,
              type: DTextInputType.email,
            ),
            5.verticalSpace,
            AppText(context.text.fullName, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            4.verticalSpace,
            DTextField(
              controller: fullNameController,
              hint: context.text.fullName,
            ),
            5.verticalSpace,
            AppText(context.text.username, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            4.verticalSpace,
            DTextField(
              controller: usernameController,
              hint: context.text.username,
            ),
            5.verticalSpace,
            AppText(context.text.birthDay, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            4.verticalSpace,
            DTextField(
              controller: birthDayController,
              hint: context.text.birthDay,
              type: DTextInputType.date,
            ),
            5.verticalSpace,
            AppText(context.text.bio, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            4.verticalSpace,
            DTextField(
              controller: bioController,
              hint: context.text.bio,
              maxLines: 5,
              type: DTextInputType.multiline,
            ),
            5.verticalSpace,
            AppText(context.text.socialNetwork, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
            15.verticalSpace,
            DIconText(
              icon: SvgPicture.asset(AppAsset.svg.facebook, width: 20.w, height: 20.h),
              text: "Facebook",
            ),
            5.verticalSpace,
            DTextField(
              controller: facebookController,
              hint: "Facebook",
              type: DTextInputType.url,
            ),
            5.verticalSpace,
            DIconText(
              icon: SvgPicture.asset(AppAsset.svg.instagram, width: 20.w, height: 20.h),
              text: "Instagram",
            ),
            5.verticalSpace,
            DTextField(
              controller: instagramController,
              hint: "Instagram",
              type: DTextInputType.url,
            ),
            5.verticalSpace,
            DIconText(
              icon: SvgPicture.asset(AppAsset.svg.youtube, width: 20.w, height: 20.h),
              text: "Youtube",
            ),
            5.verticalSpace,
            DTextField(
              controller: youtubeController,
              hint: "Youtube",
              type: DTextInputType.url,
            ),
            15.verticalSpace,
            GradientButton(
              onPressed: () {
                if (birthDayController.text.isEmpty) {
                  DMessage.showMessage(
                    message: context.text.birthdayRequired,
                    type: MessageType.danger,
                  );
                  return;
                }

                context.read<ProfileCubit>().updateProfile(AppUser(
                      name: fullNameController.text,
                      username: usernameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      birthday: birthDayController.text.toUTCDateTime,
                      bio: bioController.text,
                      facebookUrl: facebookController.text,
                      instagramUrl: instagramController.text,
                      youtubeUrl: youtubeController.text,
                    ));
              },
              text: context.text.saveEdit,
            ),
            15.verticalSpace,
          ],
        ),
      ),
    );
  }
}
