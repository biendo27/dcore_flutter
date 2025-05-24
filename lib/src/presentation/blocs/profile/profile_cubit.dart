part of '../blocs.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> with CubitActionMixin<ProfileState> {
  final IProfileRepository _profileRepository;
  final IUploadRepository _uploadRepository;
  ProfileCubit(this._profileRepository, this._uploadRepository) : super(ProfileState.initial());

  Future<String> _uploadAvatar() async {
    final BaseResponseList<AppFile> response = await _uploadRepository.uploadFile(
      UploadType.postImage,
      [File(state.avatar)],
    );
    if (response.data.isNotEmpty == true) {
      return response.data.first.url;
    }
    return '';
  }

  Future<void> fetchProfile() async {}

  void setAvatar(String avatar) {
    emit(state.copyWith(avatar: avatar));
  }

  Future<void> updateProfile(AppUser user) async {
    if (state.avatar.isNotEmpty) {
      final String avatar = await _uploadAvatar();
      user = user.copyWith(image: avatar);
    }
    executeAction(
      action: () => _profileRepository.updateProfile(user),
      setLoadingState: (state, {required bool isLoading}) => state.copyWith(isLoading: isLoading),
      onSuccess: (BaseResponse<AppUser> response) {
        AppConfig.context!.read<UserCubit>().setUserKeepWallet(response.data!);
        DMessage.showMessage(
          message: response.message,
          type: MessageType.success,
        );
        setAvatar('');
        DNavigator.back();
      },
      onFailure: (message) {
        // DMessage.showMessage(
        //   message: message,
        //   type: MessageType.error,
        // );
      },
    );
  }

  Future<void> updateLanguage(String languageCode) async {
    executeAction(
      action: () => _profileRepository.updateLanguage(languageCode),
      onSuccess: (BaseResponse response) {
        DMessage.showMessage(
          message: response.message,
          type: MessageType.success,
        );
      },
    );
  }
}
