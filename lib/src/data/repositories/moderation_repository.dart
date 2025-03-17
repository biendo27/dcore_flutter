part of 'repositories.dart';

@LazySingleton(as: IModerationRepository)
class ModerationRepository with DataStateConvertible implements IModerationRepository {
  final ModerationApi _moderationApi;
  ModerationRepository(this._moderationApi);

  @override
  Future<ModerationResponse> checkVideoBelowOneMinute(File video) {
    return requestThirdParty(apiCall: () => _moderationApi.checkVideoBelowOneMinute(video, ModerationKey.models, ModerationKey.apiUser, ModerationKey.apiSecret));
  }

  @override
  Future<ModerationResponse> checkVideoAboveOneMinute(File video) {
    ContentModerationSetting setting = AppConfig.context!.read<ConfigCubit>().state.contact.contentModerationSetting;
    int apiUser = setting.apiUser;
    String apiSecret = setting.apiSecret;
    return requestThirdParty(apiCall: () => _moderationApi.checkVideoAboveOneMinute(video, ModerationKey.models, apiUser, apiSecret));
  }
} 