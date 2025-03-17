part of '../blocs.dart';

@lazySingleton
class ThemeCubit extends HydratedCubit<ThemeType> {
  ThemeCubit() : super(ThemeType.light);

  void changeTheme(ThemeType theme) {
    if (theme == state) return;
    emit(theme);
    LogDev.trace('Change theme to ${theme.label}');
  }

  @override
  ThemeType fromJson(Map<String, dynamic> json) => ThemeType.fromString(json['theme'] as String);

  @override
  Map<String, dynamic> toJson(ThemeType state) => <String, dynamic>{'theme': state.value};
}

enum ThemeType {
  light('Light', 'light'),
  dark('Dark', 'dark');

  final String label;
  final String value;

  const ThemeType(this.label, this.value);

  static ThemeType fromString(String value) {
    return switch (value) {
      'light' => ThemeType.light,
      'dark' => ThemeType.dark,
      _ => ThemeType.light,
    };
  }

  ThemeData get themeMaterial {
    return switch (this) {
      ThemeType.light => AppThemeMaterial.lightTheme,
      ThemeType.dark => AppThemeMaterial.darkTheme,
    };
  }

  ThemeData get themeUtil {
    return switch (this) {
      ThemeType.light => AppThemeUtil.lightTheme,
      ThemeType.dark => AppThemeUtil.darkTheme,
    };
  }
}
