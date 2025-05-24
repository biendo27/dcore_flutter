part of 'themes.dart';

mixin AppCustomColor {
  static List<Color> background = [
    Color(0xFFFF15F0),
    Color(0xFFF95C70),
    Color(0xFFF58822),
    Color(0xFFD02027),
  ];

  static List<Color> gradientButton = [
    Color(0xFFE86423),
    Color(0xFFF38421),
    Color(0xFFF7704B),
    Color(0xFFF86959),
    Color(0xFFFA4A92),
  ];

  static List<Color> gradientBackground = [
    Color(0xFFE35524),
    Color(0xFFF58921),
    Color(0xFFF86463),
    Color(0xFFFF15F0),
  ];

  static List<Color> gradientAvatarBorder = [
    Color(0xFFD02027),
    Color(0xFFF58822),
    Color(0xFFF95C70),
    Color(0xFFFF15F0),
  ];

  static List<Color> gradientContainer = [
    Color(0xFFEF4A25),
    Color(0xFFF95C70),
    Color(0xFFF58921),
    Color(0xFFFF15F0),
  ];

  static List<Color> gradientTitle = [
    Color(0xFFE86423),
    Color(0xFFF38421),
    Color(0xFFF86959),
    Color(0xFFFA4A92),
  ];

  static List<Color> background2Color = [
    Color(0xFF000000),
    Color(0xFFFFFFFF),
  ];

  static List<Color> gradientPinProduct = [
    Color(0xFF000000).withValues(alpha: 0.8),
    Color(0xFFFFFFFF).withValues(alpha: 0.8),
  ];

  static Color orangeF4 = Color(0xFFF48321);
  static Color orage4DF5 = Color(0x4DF58921);
  static Color orangeF5 = Color(0xFFF58822);
  static Color orangeFF = Color(0xFFFFB800);
  static Color orangeF1 = Color(0xFFF17547);
  static Color orangeFE = Color(0xFFFE9900);
  static Color orangeF6 = Color(0xFFF67B39);
  static Color greyC4 = Color(0xFFC4C4C4);
  static Color greyAC = Color(0xFFACACAC);
  static Color greyF5 = Color(0xFFF5F5F5);
  static Color greyF2 = Color(0xFFF2F2F2);
  static Color greyCF = Color(0xFFCFCFCF);
  static Color greyD9 = Color(0xFFD9D9D9);
  static Color greyDA = Color(0xFFDADADA);
  static Color grey50 = Color(0xFF505050);
  static Color greyE5 = Color(0xFFE5E5E5);
  static Color greyE9 = Color(0xFFE9E9E9);
  static Color greyF1 = Color(0xFFF1F1F1);
  static Color greyC8 = Color(0xFFC8C6C9);
  static Color redE2 = Color(0xFFE23030);
  static Color redD0 = Color(0xFFD02027);
  static Color redD7 = Color(0xFFD72727);
  static Color redF5 = Color(0xFFF50F0F);
  static Color green05 = Color(0xFF059A2F);
  static Color green0F = Color(0xFF0F993E);
  static Color blue17 = Color(0xFF1744B4);
  static Color blue1F = Color(0xFF1F4981);
  static Color blue2B = Color(0xFF2B92C5);
  static Color blue3C = Color(0xFF3CAED9);
  static Color blueCE = Color(0xFFCEE4FB);
  static Color yellowB0 = Color(0xFFB0AB7B);
  static Color yellowFF = Color(0xFFFFB800);
  static Color black2D = Color(0xFF2D2D2D);
  static Color yellowF5 = Color(0xFFF58822);
  static Color blue4A = Color(0xFF4AC6E9);
  static Color pinkFF = Color(0xFFFF1575);
}

mixin AppTheme {
  static final ThemeData _theme = AppConfig.context!.watch<ThemeCubit>().state.themeMaterial;

  //* Color scheme
  static Color primaryColor = _theme.colorScheme.primary;
  static Color onPrimary = _theme.colorScheme.onPrimary;
  static Color primaryContainer = _theme.colorScheme.primaryContainer;
  static Color onPrimaryContainer = _theme.colorScheme.onPrimaryContainer;
  static Color secondaryColor = _theme.colorScheme.secondary;
  static Color onSecondary = _theme.colorScheme.onSecondary;
  static Color secondaryContainer = _theme.colorScheme.secondaryContainer;
  static Color onSecondaryContainer = _theme.colorScheme.onSecondaryContainer;
  static Color tertiaryColor = _theme.colorScheme.tertiary;
  static Color onTertiary = _theme.colorScheme.onTertiary;
  static Color tertiaryContainer = _theme.colorScheme.tertiaryContainer;
  static Color onTertiaryContainer = _theme.colorScheme.onTertiaryContainer;
  static Color error = _theme.colorScheme.error;
  static Color onError = _theme.colorScheme.onError;
  static Color surface = _theme.colorScheme.surface;
  static Color onSurface = _theme.colorScheme.onSurface;
  static Color surfaceContainerHighest = _theme.colorScheme.surfaceContainerHighest;
  static Color onSurfaceVariant = _theme.colorScheme.onSurfaceVariant;
  static Color surfaceTint = _theme.colorScheme.surfaceTint;
  static Color inverseSurface = _theme.colorScheme.inverseSurface;
  static Color onInverseSurface = _theme.colorScheme.onInverseSurface;
  static Color scaffoldBackgroundColor = _theme.scaffoldBackgroundColor;
  static Color outline = _theme.colorScheme.outline;
  static Color outlineVariant = _theme.colorScheme.outlineVariant;
  static Color shadow = _theme.colorScheme.shadow;
  static Color scrim = _theme.colorScheme.scrim;

  //* Text theme
  static TextTheme textTheme = _theme.textTheme;
}
