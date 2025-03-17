part of '../blocs.dart';

@lazySingleton
class LocaleCubit extends HydratedCubit<LocaleType> {
  LocaleCubit() : super(LocaleType.vi);

  void changeLocale(LocaleType locale) {
    if (locale == state) return;
    emit(locale);
    LogDev.trace('Change locale to ${locale.value}');
  }

  @override
  LocaleType fromJson(Map<String, dynamic> json) => LocaleType.fromString(json['locale'] as String);

  @override
  Map<String, dynamic> toJson(LocaleType state) => {'locale': state.value};
}

enum LocaleType {
  vi('vi', 'Tiếng Việt'),
  en('en', 'English');

  final String value;
  final String label;

  const LocaleType(this.value, this.label);

  static LocaleType fromString(String name) {
    return switch (name) {
      'vi' => LocaleType.vi,
      'en' => LocaleType.en,
      _ => LocaleType.vi,
    };
  }

  Locale get localeData {
    return switch (this) {
      LocaleType.vi => const Locale.fromSubtags(languageCode: 'vi'),
      LocaleType.en => const Locale.fromSubtags(languageCode: 'en'),
    };
  }
}
