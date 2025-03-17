part of 'themes.dart';

mixin AppThemeMaterial {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppFont.gilroy,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: lightColorScheme,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppFont.gilroy,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: darkColorScheme,
  );

  static ColorScheme lightColorScheme = ColorScheme(
    brightness: AppColorLight.brightness,
    primary: AppColorLight.primary,
    surfaceTint: AppColorLight.surfaceTint,
    onPrimary: AppColorLight.onPrimary,
    primaryContainer: AppColorLight.primaryContainer,
    onPrimaryContainer: AppColorLight.onPrimaryContainer,
    secondary: AppColorLight.secondary,
    onSecondary: AppColorLight.onSecondary,
    secondaryContainer: AppColorLight.secondaryContainer,
    onSecondaryContainer: AppColorLight.onSecondaryContainer,
    tertiary: AppColorLight.tertiary,
    onTertiary: AppColorLight.onTertiary,
    tertiaryContainer: AppColorLight.tertiaryContainer,
    onTertiaryContainer: AppColorLight.onTertiaryContainer,
    error: AppColorLight.error,
    onError: AppColorLight.onError,
    errorContainer: AppColorLight.errorContainer,
    onErrorContainer: AppColorLight.onErrorContainer,
    surface: AppColorLight.surface,
    onSurface: AppColorLight.onSurface,
    onSurfaceVariant: AppColorLight.onSurfaceVariant,
    outline: AppColorLight.outline,
    outlineVariant: AppColorLight.outlineVariant,
    shadow: AppColorLight.shadow,
    scrim: AppColorLight.scrim,
    inverseSurface: AppColorLight.inverseSurface,
    inversePrimary: AppColorLight.inversePrimary,
    primaryFixed: AppColorLight.primaryFixed,
    onPrimaryFixed: AppColorLight.onPrimaryFixed,
    primaryFixedDim: AppColorLight.primaryFixedDim,
    onPrimaryFixedVariant: AppColorLight.onPrimaryFixedVariant,
    secondaryFixed: AppColorLight.secondaryFixed,
    onSecondaryFixed: AppColorLight.onSecondaryFixed,
    secondaryFixedDim: AppColorLight.secondaryFixedDim,
    onSecondaryFixedVariant: AppColorLight.onSecondaryFixedVariant,
    tertiaryFixed: AppColorLight.tertiaryFixed,
    onTertiaryFixed: AppColorLight.onTertiaryFixed,
    tertiaryFixedDim: AppColorLight.tertiaryFixedDim,
    onTertiaryFixedVariant: AppColorLight.onTertiaryFixedVariant,
    surfaceDim: AppColorLight.surfaceDim,
    surfaceBright: AppColorLight.surfaceBright,
    surfaceContainerLowest: AppColorLight.surfaceContainerLowest,
    surfaceContainerLow: AppColorLight.surfaceContainerLow,
    surfaceContainer: AppColorLight.surfaceContainer,
    surfaceContainerHigh: AppColorLight.surfaceContainerHigh,
    surfaceContainerHighest: AppColorLight.surfaceContainerHighest,
  );

  // example

  // Define the darkColorScheme using the variables from AppColors class
  static ColorScheme darkColorScheme = ColorScheme(
    brightness: AppColorDark.brightness, // Brightness for the dark theme
    primary: AppColorDark.primary, // Primary color for dark theme
    surfaceTint: AppColorDark.surfaceTint, // Surface tint color
    onPrimary: AppColorDark.onPrimary, // Color used on top of the primary color
    primaryContainer: AppColorDark.primaryContainer, // Primary container background color
    onPrimaryContainer: AppColorDark.onPrimaryContainer, // Color used on top of the primary container

    secondary: AppColorDark.secondary, // Secondary color
    onSecondary: AppColorDark.onSecondary, // Color used on top of the secondary color
    secondaryContainer: AppColorDark.secondaryContainer, // Secondary container background
    onSecondaryContainer: AppColorDark.onSecondaryContainer, // Color used on top of secondary container

    tertiary: AppColorDark.tertiary, // Tertiary color for dark theme
    onTertiary: AppColorDark.onTertiary, // Color drawn on top of tertiary color
    tertiaryContainer: AppColorDark.tertiaryContainer, // Tertiary container background
    onTertiaryContainer: AppColorDark.onTertiaryContainer, // Color used on top of tertiary container

    error: AppColorDark.error, // Error color
    onError: AppColorDark.onError, // Color used on top of the error color
    errorContainer: AppColorDark.errorContainer, // Error container background
    onErrorContainer: AppColorDark.onErrorContainer, // Color used on top of the error container

    surface: AppColorDark.surface, // Surface color for dark backgrounds
    onSurface: AppColorDark.onSurface, // Color used on top of the surface
    onSurfaceVariant: AppColorDark.onSurfaceVariant, // Variant of surface color
    outline: AppColorDark.outline, // Outline color (e.g., borders)
    outlineVariant: AppColorDark.outlineVariant, // Lighter version of the outline

    shadow: AppColorDark.shadow, // Shadow color
    scrim: AppColorDark.scrim, // Scrim color for modal surfaces
    inverseSurface: AppColorDark.inverseSurface, // Inverse surface color for dark theme
    inversePrimary: AppColorDark.inversePrimary, // Inverse of primary color

    primaryFixed: AppColorDark.primaryFixed, // Fixed primary color across themes
    onPrimaryFixed: AppColorDark.onPrimaryFixed, // Color used on top of fixed primary
    primaryFixedDim: AppColorDark.primaryFixedDim, // Dimmed version of fixed primary
    onPrimaryFixedVariant: AppColorDark.onPrimaryFixedVariant, // Variant of on-primary-fixed

    secondaryFixed: AppColorDark.secondaryFixed, // Fixed secondary color across themes
    onSecondaryFixed: AppColorDark.onSecondaryFixed, // Color used on top of secondary fixed
    secondaryFixedDim: AppColorDark.secondaryFixedDim, // Dimmed version of secondary fixed
    onSecondaryFixedVariant: AppColorDark.onSecondaryFixedVariant, // Variant of on-secondary-fixed

    tertiaryFixed: AppColorDark.tertiaryFixed, // Fixed tertiary color
    onTertiaryFixed: AppColorDark.onTertiaryFixed, // Color used on top of fixed tertiary
    tertiaryFixedDim: AppColorDark.tertiaryFixedDim, // Dimmed version of tertiary fixed
    onTertiaryFixedVariant: AppColorDark.onTertiaryFixedVariant, // Variant of on-tertiary-fixed

    surfaceDim: AppColorDark.surfaceDim, // Dimmed surface color
    surfaceBright: AppColorDark.surfaceBright, // Brighter surface color
    surfaceContainerLowest: AppColorDark.surfaceContainerLowest, // Lowest container brightness
    surfaceContainerLow: AppColorDark.surfaceContainerLow, // Slightly brighter container
    surfaceContainer: AppColorDark.surfaceContainer, // Default container surface
    surfaceContainerHigh: AppColorDark.surfaceContainerHigh, // Brighter container background
    surfaceContainerHighest: AppColorDark.surfaceContainerHighest, // Brightest container background
  );
}

mixin AppColorLight {
  // Basic Colors
  static const Brightness brightness = Brightness.light;
  static const Color primary = Color(0xFFF7704B);
  static const Color surfaceTint = Color(0xFF8F4B39);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF3A0A01);

  static const Color secondary = Color(0xFF77574E);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFDBD1);
  static const Color onSecondaryContainer = Color(0xFF2C150F);

  static const Color tertiary = Color(0xFF6C5D2E);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFF6E1A6);
  static const Color onTertiaryContainer = Color(0xFF231B00);

  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF231917);
  static const Color onSurfaceVariant = Color(0xFF505050);
  static const Color surfaceDim = Color(0xFFE8D6D2);
  static const Color surfaceBright = Color(0xFFFFF8F6);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFFFF1ED);
  static const Color surfaceContainer = Color(0xFFF2F2F2);
  static const Color surfaceContainerHigh = Color(0xFFF7E4E0);
  static const Color surfaceContainerHighest = Color(0xFFF5F5F5);

  // Inverse and Fixed Colors
  static const Color inverseSurface = Color(0xFF392E2B);
  static const Color inversePrimary = Color(0xFFF58921);

  static const Color primaryFixed = Color(0xFFFFDBD1);
  static const Color onPrimaryFixed = Color(0xFF3A0A01);
  static const Color primaryFixedDim = Color(0xFFFFB5A1);
  static const Color onPrimaryFixedVariant = Color(0xFF723524);

  static const Color secondaryFixed = Color(0xFFFFDBD1);
  static const Color onSecondaryFixed = Color(0xFF2C150F);
  static const Color secondaryFixedDim = Color(0xFFE7BDB2);
  static const Color onSecondaryFixedVariant = Color(0xFF5D4038);

  static const Color tertiaryFixed = Color(0xFFF6E1A6);
  static const Color onTertiaryFixed = Color(0xFF231B00);
  static const Color tertiaryFixedDim = Color(0xFFD9C58D);
  static const Color onTertiaryFixedVariant = Color(0xFF534619);

  // Outline, Shadow, and Scrim Colors
  static const Color outline = Color(0xFFF7704B);
  static const Color outlineVariant = Color(0xFFDADADA);
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
}

mixin AppColorDark {
  //  theme brightness: specifies that this ColorScheme is for dark mode
  static const Brightness brightness = Brightness.dark;

  // Primary color: main brand color for the dark theme
  static const Color primary = Color(0xFFFFB5A1);

  // Surface tint: used to tint components like app bars and bottom sheets
  static const Color surfaceTint = Color(0xFFFFB5A1);

  // onPrimary: the color that will appear on top of the primary color (e.g., text, icons)
  static const Color onPrimary = Color(0xFF561F10);

  // primaryContainer: a lighter or variant of the primary color used in containers
  static const Color primaryContainer = Color(0xFF723524);

  // onPrimaryContainer: the color to display on top of the primary container
  static const Color onPrimaryContainer = Color(0xFFFFDBD1);

  // Secondary color: another important color in the app used to highlight UI elements
  static const Color secondary = Color(0xFFE7BDB2);

  // onSecondary: the color that will be drawn on top of the secondary color
  static const Color onSecondary = Color(0xFF442A23);

  // secondaryContainer: a lighter or variant of the secondary color for container backgrounds
  static const Color secondaryContainer = Color(0xFF5D4038);

  // onSecondaryContainer: the color to be displayed on top of the secondary container
  static const Color onSecondaryContainer = Color(0xFFFFDBD1);

  // Tertiary color: an additional color for styling your app (can be used for less prominent elements)
  static const Color tertiary = Color(0xFFD9C58D);

  // onTertiary: the color drawn on top of the tertiary color
  static const Color onTertiary = Color(0xFF3B2F05);

  // tertiaryContainer: a lighter or variant of the tertiary color used for container backgrounds
  static const Color tertiaryContainer = Color(0xFF534619);

  // onTertiaryContainer: the color drawn on top of the tertiary container
  static const Color onTertiaryContainer = Color(0xFFF6E1A6);

  // Error color: used to indicate errors in forms, etc.
  static const Color error = Color(0xFFFFB4AB);

  // onError: the color used on top of the error color (typically for text)
  static const Color onError = Color(0xFF690005);

  // errorContainer: background color for error messages
  static const Color errorContainer = Color(0xFF93000A);

  // onErrorContainer: color drawn on top of the error container background
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  // Surface color: used for backgrounds of cards, sheets, etc.
  static const Color surface = Color(0xFF1A110F);

  // onSurface: the color used on top of the surface color (e.g., text)
  static const Color onSurface = Color(0xFFF1DFDA);

  // onSurfaceVariant: a variant color used for less important surface text
  static const Color onSurfaceVariant = Color(0xFFD8C2BC);

  // Outline: color used for things like borders and dividers
  static const Color outline = Color(0xFFA08C88);

  // outlineVariant: a lighter or alternative version of the outline color
  static const Color outlineVariant = Color(0xFF53433F);

  // Shadow: color used for shadow effects in the UI
  static const Color shadow = Color(0xFF000000);

  // Scrim: used in modal surfaces like drawers to cover the background
  static const Color scrim = Color(0xFF000000);

  // Inverse surface: a color contrasting the surface, often used in elevated components like modals
  static const Color inverseSurface = Color(0xFFF1DFDA);

  // inversePrimary: an inverted version of the primary color for text or icons on a contrasting background
  static const Color inversePrimary = Color(0xFF8F4B39);

  // Primary fixed: color used for areas that remain the same across both light and dark themes
  static const Color primaryFixed = Color(0xFFFFDBD1);

  // onPrimaryFixed: the color displayed on top of the fixed primary color
  static const Color onPrimaryFixed = Color(0xFF3A0A01);

  // Primary fixed dim: a dimmed or muted version of the primary fixed color
  static const Color primaryFixedDim = Color(0xFFFFB5A1);

  // onPrimaryFixedVariant: a variant of the color used on fixed primary elements
  static const Color onPrimaryFixedVariant = Color(0xFF723524);

  // Secondary fixed: fixed secondary color for areas that stay consistent in both light/dark themes
  static const Color secondaryFixed = Color(0xFFFFDBD1);

  // onSecondaryFixed: the color displayed on top of the fixed secondary color
  static const Color onSecondaryFixed = Color(0xFF2C150F);

  // Secondary fixed dim: a muted or dimmed version of the secondary fixed color
  static const Color secondaryFixedDim = Color(0xFFE7BDB2);

  // onSecondaryFixedVariant: the color used on top of a secondary fixed variant
  static const Color onSecondaryFixedVariant = Color(0xFF5D4038);

  // Tertiary fixed: fixed tertiary color for consistent UI elements
  static const Color tertiaryFixed = Color(0xFFF6E1A6);

  // onTertiaryFixed: the color used on top of the fixed tertiary color
  static const Color onTertiaryFixed = Color(0xFF231B00);

  // Tertiary fixed dim: a muted version of the fixed tertiary color
  static const Color tertiaryFixedDim = Color(0xFFD9C58D);

  // onTertiaryFixedVariant: the color displayed on top of a variant of the tertiary fixed color
  static const Color onTertiaryFixedVariant = Color(0xFF534619);

  // surfaceDim: a dimmed version of the surface color for dark theme
  static const Color surfaceDim = Color(0xFF1A110F);

  // surfaceBright: a brighter version of the surface color
  static const Color surfaceBright = Color(0xFF423734);

  // surfaceContainerLowest: the lightest container background
  static const Color surfaceContainerLowest = Color(0xFF140C0A);

  // surfaceContainerLow: slightly darker than the lowest container background
  static const Color surfaceContainerLow = Color(0xFF231917);

  // surfaceContainer: a default container background
  static const Color surfaceContainer = Color(0xFF271D1B);

  // surfaceContainerHigh: a brighter container background used for elevated containers
  static const Color surfaceContainerHigh = Color(0xFF322825);

  // surfaceContainerHighest: the highest brightness for container backgrounds
  static const Color surfaceContainerHighest = Color(0xFF3D3230);
}
