part of '../blocs.dart';

@lazySingleton
class ConfigCubit extends Cubit<ConfigState> with CubitActionMixin<ConfigState> {
  final IConfigRepository _configRepository;
  ConfigCubit(this._configRepository) : super(ConfigState.initial());

  void init() {
    fetchSplash();
    fetchContact();
    fetchAppName();
    fetchTermsOfUseApp();
    fetchTermOfSalePolicy();
    fetchPrivacyPolicy();
  }

  Future<void> fetchSplash() async {
    executeListAction<AppIntro>(
      action: _configRepository.fetchSplash,
      onSuccess: (response) => emit(state.copyWith(splash: response.data)),
    );
  }

  Future<void> fetchContact() async {
    executeAction<Contact>(
      action: _configRepository.fetchConfig,
      onSuccess: (response) {
        emit(state.copyWith(contact: response.data!));
        AppConfig.context?.read<LiveSettingCubit>().liveService.setAppId(response.data!.livestreamConfig.appId);
      },
    );
  }

  Future<void> fetchAppName() async {
    executeAction<String>(
      action: _configRepository.fetchAppName,
      onSuccess: (response) => emit(state.copyWith(appName: response.data!)),
    );
  }

  Future<void> fetchTermsOfUseApp() async {
    executeAction<String>(
      action: _configRepository.fetchTermsOfUseApp,
      onSuccess: (response) => emit(state.copyWith(termsOfUseApp: response.data!)),
    );
  }

  Future<void> fetchTermOfSalePolicy() async {
    executeAction<String>(
      action: _configRepository.fetchTermOfSalePolicy,
      onSuccess: (response) => emit(state.copyWith(termOfSalePolicy: response.data!)),
    );
  }

  Future<void> fetchPrivacyPolicy() async {
    executeAction<String>(
      action: _configRepository.fetchPrivacyPolicy,
      onSuccess: (response) => emit(state.copyWith(privacyPolicy: response.data!)),
    );
  }
}
