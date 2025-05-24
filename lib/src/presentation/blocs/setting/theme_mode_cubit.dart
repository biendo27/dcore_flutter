part of '../blocs.dart';

@lazySingleton
class ThemeModeCubit extends HydratedCubit<ThemeModeType> {
  ThemeModeCubit() : super(ThemeModeType.light);

  void changeThemeMode(ThemeModeType themeMode) {
    if (themeMode == state) return;
    emit(themeMode);
    LogDev.trace('Change theme mode to ${themeMode.label}');
  }

  @override
  ThemeModeType? fromJson(Map<String, dynamic> json) => ThemeModeType.fromString(json['themeMode'] as String);

  @override
  Map<String, dynamic>? toJson(ThemeModeType state) => <String, dynamic>{'themeMode': state.value};
}

enum ThemeModeType {
  system('System', 'system'), // 'system' is a keyword, use 'systemMode' instead of 'system'
  light('Light', 'light'),
  dark('Dark', 'dark');

  final String label;
  final String value;

  const ThemeModeType(this.label, this.value);

  static ThemeModeType fromString(String name) {
    return switch (name) {
      'system' => ThemeModeType.system,
      'light' => ThemeModeType.light,
      'dark' => ThemeModeType.dark,
      _ => ThemeModeType.system,
    };
  }

  ThemeMode get themeModeData {
    return switch (this) {
      ThemeModeType.system => ThemeMode.system,
      ThemeModeType.light => ThemeMode.light,
      ThemeModeType.dark => ThemeMode.dark,
    };
  }
}
