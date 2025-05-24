part of '../blocs.dart';

@freezed
abstract class ConfigState with _$ConfigState {
  const factory ConfigState({
    @Default([]) List<AppIntro> splash,
    @Default(Contact()) Contact contact,
    @Default('') String appName,
    @Default('') String termsOfUseApp,
    @Default('') String termOfSalePolicy,
    @Default('') String privacyPolicy,
  }) = _ConfigState;
  factory ConfigState.initial() => ConfigState();
}
