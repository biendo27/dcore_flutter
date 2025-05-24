part of '../models.dart';

@freezed
abstract class Contact with _$Contact {
  const factory Contact({
    @Default('') String company,
    @Default('') String address,
    @Default('') String website,
    @Default('') String hotline,
    @Default('') String email,
    @Default(ContentModerationSetting()) ContentModerationSetting contentModerationSetting,
    @Default(LivestreamSetting()) LivestreamSetting livestreamConfig,
    @Default('') String leaveRequestPolicy,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
}
