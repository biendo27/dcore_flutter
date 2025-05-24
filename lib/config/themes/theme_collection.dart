part of 'themes.dart';

mixin LightTheme {
  static MenuBarThemeData menuTheme() {
    return const MenuBarThemeData(
      style: MenuStyle(
        alignment: Alignment.center,
        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFFFFFFF)),
        elevation: WidgetStatePropertyAll<double>(2.0),
      ),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFF000000),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      toolbarHeight: 56.0,
      actionsIconTheme: const IconThemeData(
        color: Color(0xFF000000),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF000000),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      titleTextStyle: TextStyle(
        color: const Color(0xFF000000),
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w600,
        height: 1.0.h,
      ),
      shadowColor: const Color(0X991A1C1E),
    );
  }

  static BottomNavigationBarThemeData bottomNavBarTheme() {
    return BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      selectedItemColor: const Color(0xFF89BF05),
      unselectedItemColor: const Color(0xCCACACAC),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
          color: const Color(0xFF89BF05),
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(
          color: const Color(0xCCACACAC),
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w500),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme:
          const IconThemeData(color: Color(0xFFFFFFFF), size: 24.0),
      unselectedIconTheme:
          const IconThemeData(color: Color(0xCCFFFFFF), size: 24.0),
      elevation: 15.0,
    );
  }

  static PageTransitionsTheme pageTransitionTheme() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      },
    );
  }

  static DatePickerThemeData datePickerTheme() {
    return const DatePickerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      headerBackgroundColor: Color(0xFF1976D2),
      rangePickerBackgroundColor: Color(0xFF1976D2),
    );
  }

  static OverflowBar overflowBarTheme() {
    return const OverflowBar(
      spacing: 8.0,
      overflowSpacing: 4.0,
      children: <Widget>[
        // Add your buttons or other widgets here
      ],
    );
  }

  static ToggleButtonsThemeData toggleButtonTheme() {
    return const ToggleButtonsThemeData(
      fillColor: Color(0xFFFFFFFF),
      color: Color(0xFF1976D2),
      selectedColor: Color(0xFF0D47A1),
      borderColor: Color(0xFFBDBDBD),
    );
  }

  static BottomAppBarTheme bottomAppBarTheme() {
    return BottomAppBarTheme(
      color: const Color(0xFF1976D2),
      elevation: 3.0,
      surfaceTintColor: const Color(0xFFFFFFFF),
      height: 84.0.h,
    );
  }

  static BadgeThemeData badgeTheme() {
    return const BadgeThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      textColor: Color(0X00000000),
    );
  }

  static DropdownMenuThemeData dropdownMenuTheme() {
    return const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFF000000),
        iconColor: Color(0xFF1976D2),
      ),
    );
  }

  static DialogTheme dialogTheme() {
    return const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
    );
  }

  static DividerThemeData dividerTheme() {
    return const DividerThemeData(
      indent: 3.0,
      endIndent: 3.0,
      thickness: 1.0,
      color: Color(0xFFACACAC),
    );
  }

  static DrawerThemeData drawerTheme() {
    return DrawerThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 3.0,
      width: 330.0.w,
    );
  }

  static FloatingActionButtonThemeData floatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      foregroundColor: Color(0xFFFFFFFF),
      iconSize: 16.0,
      backgroundColor: Color(0xFF1976D2),
      enableFeedback: true,
    );
  }

  static SnackBarThemeData snackBarTheme() {
    return const SnackBarThemeData(
      backgroundColor: Color(0xFF008080),
      elevation: 0.0,
      contentTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
    );
  }

  static CardTheme cardTheme() {
    return const CardTheme(
      color: Color(0xFFFFFFFF),
      shadowColor: Color(0xFFFFFFFF),
      elevation: 3.0,
    );
  }

  static ListTileThemeData listTitleTheme() {
    return ListTileThemeData(
      tileColor: const Color(0xFFFFFFFF),
      iconColor: const Color(0xFFACACAC),
      selectedColor: const Color(0xFFF1EFEF),
      titleTextStyle: TextStyle(
          color: const Color(0xFF000000),
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w600),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      subtitleTextStyle: TextStyle(
          color: const Color(0xFF000000),
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w300),
      horizontalTitleGap: 10.0,
      dense: true,
    );
  }

  static CheckboxThemeData checkBoxTheme() {
    return CheckboxThemeData(
      checkColor: WidgetStateProperty.all<Color>(const Color(0xFF89BF05)),
      fillColor: WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      side: WidgetStateBorderSide.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(
              color: const Color(0xFF89BF05),
              width: 2.0.w,
              style: BorderStyle.solid,
            );
          }

          return BorderSide(
            color: const Color(0xFFACACAC),
            width: 2.0.w,
            style: BorderStyle.solid,
          );
        },
      ),
    );
  }

  static IconThemeData iconTheme() =>
      const IconThemeData(color: Color(0xFF000000));

  static RadioThemeData radioButtonTheme() {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF89BF05);
        }

        return const Color(0xFFACACAC);
      }),
      overlayColor: WidgetStateProperty.all<Color>(const Color(0xFFACACAC)),
    );
  }

  static FilledButtonThemeData filledButtonTheme() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF89BF05)),
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(
            fontSize: 20.0.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF89BF05))),
      ),
    );
  }

  static SwitchThemeData switchTheme() {
    return SwitchThemeData(
      trackColor: WidgetStateProperty.all<Color>(const Color(0xFFE9E9E9)),
      thumbColor: WidgetStateProperty.all<Color>(const Color(0xFF89BF05)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  static IconButtonThemeData iconButtonTheme() {
    return IconButtonThemeData(
      style: ButtonStyle(
        iconSize: WidgetStateProperty.all<double>(16.0),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0X00000000)),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
      ),
    );
  }

  static ChipThemeData chipTheme() {
    return const ChipThemeData(
      backgroundColor: Color(0xFF26C6DA),
      elevation: 3.0,
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0XFFFFFFFF)),
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1744B4)),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1744B4)),
        ),
        elevation: WidgetStateProperty.all<double>(0.0),
      ),
    );
  }

  static TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        alignment: Alignment.center,
      ),
    );
  }

  static TabBarTheme tabBarTheme() {
    return TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: const Color(0xFFFFFFFF),
        labelColor: const Color(0xFFFFFFFF),
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF000000),
              width: 1.0.w,
              style: BorderStyle.solid,
            ),
          ),
        ));
  }

  static TextTheme textTheme() {
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: 24.0.sp,
        color: const Color(0xFF000000),
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0.sp,
        color: const Color(0xFF000000),
        fontWeight: FontWeight.w300,
      ),
      bodySmall: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
        fontWeight: FontWeight.w300,
      ),
      titleLarge: TextStyle(
        fontSize: 16.0.sp,
        color: const Color(0xFF000000),
      ),
      titleMedium: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF000000),
      ),
      titleSmall: TextStyle(
        fontSize: 12.0.sp,
        fontWeight: FontWeight.w300,
        color: const Color(0xFF000000),
      ),
      //? Button Text
      labelLarge: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0.sp,
        color: const Color(0xFF000000),
        letterSpacing: 1.0,
      ),
      labelSmall: TextStyle(
        fontSize: 10.0.sp,
        color: const Color(0xFF000000),
        letterSpacing: 1.0,
      ),
      displayLarge: TextStyle(
        fontSize: 32.0.sp,
        color: const Color(0xFF000000),
      ),
      displayMedium: TextStyle(
        fontSize: 20.0.sp,
        color: const Color(0xFF000000),
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        fontSize: 18.0.sp,
        color: const Color(0xFF000000),
      ),
    );
  }

  static ColorScheme colorScheme() {
    return const ColorScheme.light(
      brightness: Brightness.dark,
      primary: Color(0xFF89BF05),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD1E4FF),
      onPrimaryContainer: Color(0xFF001D36),
      secondary: Color(0xFF167EE6),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFF8F8F8),
      onSecondaryContainer: Color(0xFF101C2B),
      surface: Color(0xFF000000),
      onSurface: Color(0xFF1A1C1E),
      surfaceTint: Color(0xFFD9D9D9),
      surfaceContainerHighest: Color(0xFFE9E9E9),
      onSurfaceVariant: Color(0xFFB7CCFF),
      inverseSurface: Color(0xFFFBFBFB),
      error: Color(0xFFE23030),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF001D36),
      tertiary: Color(0xFF1744B4),
      onTertiary: Color(0xFFFFECE1),
      tertiaryContainer: Color(0xFFEFF3FF),
      onTertiaryContainer: Color(0xFF059A2F),
      outline: Color(0xFFD8D9DB),
      outlineVariant: Color(0xFFACACAC),
      scrim: Color(0xFFFFB800),
      shadow: Color(0xFF000000),
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      alignLabelWithHint: true,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      isCollapsed: true,
      isDense: true,
      contentPadding: EdgeInsets.all(14).w,
      hintStyle: TextStyle(
          color: const Color(0xFFACACAC),
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w500),
      labelStyle: TextStyle(
          color: const Color(0xFFACACAC),
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w500),
      errorStyle: TextStyle(
          color: const Color(0xFFF5360F),
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w500),
      fillColor: const Color(0xFFF5F5F5),
      hintFadeDuration: Duration(milliseconds: 300),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFEAEAEA)),
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFEAEAEA)),
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF89BF05)),
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFBA1A1A)),
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFBA1A1A)),
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFACACAC)),
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0XFF000000)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        side: WidgetStatePropertyAll<BorderSide>(BorderSide(
            color: const Color(0xFF89BF05),
            width: 1.0.w,
            style: BorderStyle.solid)),
        textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(
            fontSize: 20.0.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000))),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF89BF05)),
        alignment: Alignment.center,
      ),
    );
  }

  static SegmentedButtonThemeData segmentedButtonTheme() {
    return SegmentedButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        alignment: Alignment.center,
      ),
    );
  }

  static ActionIconThemeData actionIconTheme() {
    return ActionIconThemeData(
      backButtonIconBuilder: (context) {
        return const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF000000),
          size: 24.0,
        );
      },
      closeButtonIconBuilder: (context) {
        return const Icon(
          Icons.close,
          color: Color(0xFF000000),
          size: 24.0,
        );
      },
      drawerButtonIconBuilder: (context) {
        return const Icon(
          Icons.menu,
          color: Color(0xFF000000),
          size: 24.0,
        );
      },
      endDrawerButtonIconBuilder: (context) {
        return Container(width: 0);
      },
    );
  }

  static MaterialBannerThemeData bannerTheme() {
    return MaterialBannerThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      contentTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      leadingPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      elevation: 2.0,
      shadowColor: const Color(0xFF000000),
    );
  }

  static BottomSheetThemeData bottomSheetTheme() {
    return const BottomSheetThemeData(
      backgroundColor: Color(0xFFD1E4FF),
      elevation: 2.0,
      modalBackgroundColor: Color(0xFFD1E4FF),
      modalElevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  static ButtonThemeData buttonTheme() {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      colorScheme: colorScheme(),
      buttonColor: const Color(0xFF89BF05),
      disabledColor: const Color(0xFFD1E4FF),
      highlightColor: const Color(0xFFD1E4FF),
      splashColor: const Color(0xFFD1E4FF),
      focusColor: const Color(0xFFD1E4FF),
      hoverColor: const Color(0xFFD1E4FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      alignedDropdown: false,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      height: 36.0.h,
      minWidth: 88.0.w,
    );
  }

  static ExpansionTileThemeData expansionTileTheme() {
    return ExpansionTileThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      textColor: const Color(0xFF000000),
      iconColor: const Color(0xFFACACAC),
      collapsedIconColor: const Color(0xFFACACAC),
      expandedAlignment: Alignment.centerLeft,
      tilePadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      childrenPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  static MenuButtonThemeData menuButtonTheme() {
    return MenuButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        alignment: Alignment.center,
      ),
    );
  }

  static PopupMenuThemeData popupMenuTheme() {
    return PopupMenuThemeData(
      color: const Color(0xFFD1E4FF),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      textStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
    );
  }

  static DataTableThemeData dataTableTheme() {
    return DataTableThemeData(
      dataTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
      headingRowColor: WidgetStateProperty.all<Color>(const Color(0xFFD1E4FF)),
      headingRowHeight: 56.0,
      horizontalMargin: 0.0,
      columnSpacing: 0.0,
      dividerThickness: 1.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD1E4FF),
          width: 1.0.w,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  static MenuBarThemeData menuBarTheme() {
    return const MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFD1E4FF)),
        elevation: WidgetStatePropertyAll<double>(2.0),
        alignment: Alignment.center,
      ),
    );
  }

  static NavigationBarThemeData navigationBarTheme() {
    return NavigationBarThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      indicatorColor: const Color(0xFF1976D2),
      elevation: 2.0,
      shadowColor: const Color(0xFF000000),
      iconTheme: const WidgetStatePropertyAll<IconThemeData>(
        IconThemeData(
          color: Color(0xFF1976D2),
          size: 24.0,
          opacity: 1.0,
          fill: 1.0,
        ),
      ),
      labelTextStyle: WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          fontSize: 14.0.sp,
          color: const Color(0xFF1976D2),
        ),
      ),
      height: 56.0.h,
    );
  }

  static navigationDrawerTheme() {
    return NavigationDrawerThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 2.0,
      shadowColor: const Color(0xFF000000),
      iconTheme: const WidgetStatePropertyAll<IconThemeData>(
        IconThemeData(
          color: Color(0xFF1976D2),
          size: 24.0,
          opacity: 1.0,
          fill: 1.0,
        ),
      ),
      labelTextStyle: WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          fontSize: 14.0.sp,
          color: const Color(0xFF1976D2),
        ),
      ),
    );
  }

  static progressIndicatorTheme() {
    return const ProgressIndicatorThemeData(
      color: Color(0xFF1976D2),
    );
  }

  static navigationRailTheme() {
    return NavigationRailThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      elevation: 2.0,
      selectedIconTheme: const IconThemeData(
        color: Color(0xFF1976D2),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      selectedLabelTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF1976D2),
      ),
      unselectedIconTheme: const IconThemeData(
        color: Color(0xFF1976D2),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      unselectedLabelTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF1976D2),
      ),
      minWidth: 72.0.w,
      groupAlignment: 0.0,
      labelType: NavigationRailLabelType.none,
    );
  }

  static TimePickerThemeData timePickerTheme() {
    return TimePickerThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      hourMinuteTextColor: const Color(0xFF000000),
      hourMinuteColor: const Color(0xFFF8F8F8),
      dayPeriodTextColor: const Color(0xFF000000),
      dayPeriodColor: const Color(0xFFF8F8F8),
      dialHandColor: const Color(0xFF1976D2),
      dialBackgroundColor: const Color(0xFFD1E4FF),
      dialTextColor: const Color(0xFF1976D2),
      entryModeIconColor: const Color(0xFF1976D2),
      hourMinuteTextStyle:
          TextStyle(fontSize: 24.0.sp, color: const Color(0xFF000000)),
      dayPeriodTextStyle:
          TextStyle(fontSize: 24.0.sp, color: const Color(0xFF000000)),
      dayPeriodBorderSide: BorderSide(
          color: const Color(0xFF1976D2),
          width: 1.0.w,
          style: BorderStyle.solid),
      helpTextStyle:
          TextStyle(fontSize: 20.0.sp, color: const Color(0xFF1976D2)),
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xFFF8F8F8), iconColor: Color(0xFFACACAC)),
      hourMinuteShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      dayPeriodShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }
}

mixin DarkTheme {
  static MenuBarThemeData menuTheme() {
    return const MenuBarThemeData(
      style: MenuStyle(
        alignment: Alignment.center,
        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFFFFFFF)),
        elevation: WidgetStatePropertyAll<double>(2.0),
      ),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 2.0,
      backgroundColor: const Color(0xFFFFFFFF),
      foregroundColor: const Color(0xFF000000),
      centerTitle: true,
      titleSpacing: 50.0,
      toolbarHeight: 56.0,
      actionsIconTheme: const IconThemeData(
        color: Color(0xFF000000),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF000000),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      titleTextStyle: TextStyle(
        color: const Color(0xFF000000),
        fontSize: 24.0.sp,
        height: 1.0.h,
      ),
      shadowColor: const Color(0X991A1C1E),
    );
  }

  static BottomNavigationBarThemeData bottomNavBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1976D2),
      selectedItemColor: Color(0xFFFFFFFF),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Color(0xCCFFFFFF),
      selectedLabelStyle: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
      unselectedLabelStyle: TextStyle(color: Color(0xFFFFFFFF)),
      selectedIconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
        size: 24.0,
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xCCFFFFFF),
        size: 24.0,
      ),
      elevation: 1.0,
    );
  }

  static PageTransitionsTheme pageTransitionTheme() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      },
    );
  }

  static DatePickerThemeData datePickerTheme() {
    return const DatePickerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      headerBackgroundColor: Color(0xFF1976D2),
      rangePickerBackgroundColor: Color(0xFF1976D2),
    );
  }

  static OverflowBar overflowBarTheme() {
    return const OverflowBar(
      spacing: 8.0,
      overflowSpacing: 4.0,
      children: <Widget>[
        // Add your buttons or other widgets here
      ],
    );
  }

  static ToggleButtonsThemeData toggleButtonTheme() {
    return const ToggleButtonsThemeData(
      fillColor: Color(0xFFFFFFFF),
      color: Color(0xFF1976D2),
      selectedColor: Color(0xFF0D47A1),
      borderColor: Color(0xFFBDBDBD),
    );
  }

  static BottomAppBarTheme bottomAppBarTheme() {
    return BottomAppBarTheme(
      color: const Color(0xFF1976D2),
      elevation: 3.0,
      surfaceTintColor: const Color(0xFFFFFFFF),
      height: 84.0.h,
    );
  }

  static BadgeThemeData badgeTheme() {
    return const BadgeThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      textColor: Color(0X00000000),
    );
  }

  static DropdownMenuThemeData dropdownMenuTheme() {
    return const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFF000000),
        iconColor: Color(0xFF1976D2),
      ),
    );
  }

  static DialogTheme dialogTheme() {
    return const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
    );
  }

  static DividerThemeData dividerTheme() {
    return const DividerThemeData(
      indent: 3.0,
      endIndent: 3.0,
      thickness: 1.0,
      color: Color(0xFF000000),
    );
  }

  static DrawerThemeData drawerTheme() {
    return DrawerThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 3.0,
      width: 330.0.w,
    );
  }

  static FloatingActionButtonThemeData floatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      foregroundColor: Color(0xFFFFFFFF),
      iconSize: 16.0,
      backgroundColor: Color(0xFF1976D2),
      enableFeedback: true,
    );
  }

  static SnackBarThemeData snackBarTheme() {
    return const SnackBarThemeData(
      backgroundColor: Color(0xFF008080),
      elevation: 0.0,
      contentTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
    );
  }

  static CardTheme cardTheme() {
    return const CardTheme(
      color: Color(0xFFFFFFFF),
      shadowColor: Color(0xFFFFFFFF),
      elevation: 3.0,
    );
  }

  static ListTileThemeData listTitleTheme() {
    return const ListTileThemeData(
      tileColor: Color(0xFFFFFFFF),
      iconColor: Color(0xFF1976D2),
      selectedColor: Color(0xFFF1EFEF),
      horizontalTitleGap: 10.0,
      dense: true,
    );
  }

  static CheckboxThemeData checkBoxTheme() {
    return CheckboxThemeData(
      checkColor: WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
      fillColor: WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
    );
  }

  static IconThemeData iconTheme() =>
      const IconThemeData(color: Color(0xFF000000));

  static RadioThemeData radioButtonTheme() {
    return RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
      overlayColor: WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
    );
  }

  static FilledButtonThemeData filledButtonTheme() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0XFFFF4300)),
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
      ),
    );
  }

  static SwitchThemeData switchTheme() {
    return SwitchThemeData(
      trackColor: WidgetStateProperty.all<Color>(
        const Color(0xFF17CB21),
      ),
    );
  }

  static IconButtonThemeData iconButtonTheme() {
    return IconButtonThemeData(
      style: ButtonStyle(
        iconSize: WidgetStateProperty.all<double>(16.0),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0X00000000)),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
      ),
    );
  }

  static ChipThemeData chipTheme() {
    return const ChipThemeData(
      backgroundColor: Color(0xFF26C6DA),
      elevation: 3.0,
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        elevation: WidgetStateProperty.all<double>(0.0),
      ),
    );
  }

  static TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        alignment: Alignment.center,
      ),
    );
  }

  static TabBarTheme tabBarTheme() {
    return TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: const Color(0xFFFFFFFF),
        labelColor: const Color(0xFFFFFFFF),
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF000000),
              width: 1.0.w,
              style: BorderStyle.solid,
            ),
          ),
        ));
  }

  static TextTheme textTheme() {
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16.0.sp,
        color: const Color(0xFF000000),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
      bodySmall: TextStyle(
        fontSize: 12.0.sp,
        color: const Color(0xFF000000),
      ),
      titleLarge: TextStyle(
        fontSize: 16.0.sp,
        color: const Color(0xFF000000),
      ),
      titleMedium: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
      titleSmall: TextStyle(
        fontSize: 12.0.sp,
        color: const Color(0xFF000000),
      ),
      labelLarge: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
        letterSpacing: 1.0,
      ),
    );
  }

  static ColorScheme colorScheme() {
    return const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xFF1976D2),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD1E4FF),
      onPrimaryContainer: Color(0xFF001D36),
      secondary: Color(0xFF535F70),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD7E3F7),
      onSecondaryContainer: Color(0xFF101C2B),
      surface: Color(0xFF000000),
      onSurface: Color(0xFF1A1C1E),
      surfaceTint: Color(0xFFD1E4FF),
      surfaceContainerHighest: Color(0xFF646870),
      onSurfaceVariant: Color(0xFF001D36),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF001D36),
      tertiary: Color(0xFF6B5778),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF2DAFF),
      onTertiaryContainer: Color(0xFF251431),
      outline: Color(0xFF1976D2),
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    return const InputDecorationTheme(
      alignLabelWithHint: true,
      filled: true,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      isCollapsed: true,
      isDense: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        alignment: Alignment.center,
      ),
    );
  }

  static SegmentedButtonThemeData segmentedButtonTheme() {
    return SegmentedButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        alignment: Alignment.center,
      ),
    );
  }

  static ActionIconThemeData actionIconTheme() {
    return ActionIconThemeData(
      backButtonIconBuilder: (context) {
        return const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF000000),
          size: 24.0,
        );
      },
      closeButtonIconBuilder: (context) {
        return const Icon(
          Icons.close,
          color: Color(0xFF000000),
          size: 24.0,
        );
      },
      drawerButtonIconBuilder: (context) {
        return const Icon(
          Icons.menu,
          color: Color(0xFF000000),
          size: 24.0,
        );
      },
      endDrawerButtonIconBuilder: (context) {
        return const Icon(
          Icons.menu,
          color: Color(0xFF000000),
          size: 24.0,
        );
      },
    );
  }

  static MaterialBannerThemeData bannerTheme() {
    return MaterialBannerThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      contentTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      leadingPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      elevation: 2.0,
      shadowColor: const Color(0xFF000000),
    );
  }

  static BottomSheetThemeData bottomSheetTheme() {
    return const BottomSheetThemeData(
      backgroundColor: Color(0xFFD1E4FF),
      elevation: 2.0,
      modalBackgroundColor: Color(0xFFD1E4FF),
      modalElevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  static ButtonThemeData buttonTheme() {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      colorScheme: colorScheme(),
      buttonColor: const Color(0xFF89BF05),
      disabledColor: const Color(0xFFD1E4FF),
      highlightColor: const Color(0xFFD1E4FF),
      splashColor: const Color(0xFFD1E4FF),
      focusColor: const Color(0xFFD1E4FF),
      hoverColor: const Color(0xFFD1E4FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      alignedDropdown: false,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      height: 36.0.h,
      minWidth: 88.0.w,
    );
  }

  static ExpansionTileThemeData expansionTileTheme() {
    return ExpansionTileThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      textColor: const Color(0xFF000000),
      iconColor: const Color(0xFF000000),
      collapsedIconColor: const Color(0xFF000000),
      expandedAlignment: Alignment.centerLeft,
      tilePadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      childrenPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  static MenuButtonThemeData menuButtonTheme() {
    return MenuButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        overlayColor: WidgetStateProperty.all<Color>(const Color(0X0C000000)),
        elevation: WidgetStateProperty.all<double>(0.0),
        iconSize: WidgetStateProperty.all<double>(16.0),
        iconColor: WidgetStateProperty.all<Color>(const Color(0xFF1976D2)),
        alignment: Alignment.center,
      ),
    );
  }

  static PopupMenuThemeData popupMenuTheme() {
    return PopupMenuThemeData(
      color: const Color(0xFFD1E4FF),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      textStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
    );
  }

  static DataTableThemeData dataTableTheme() {
    return DataTableThemeData(
      dataTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF000000),
      ),
      headingRowColor: WidgetStateProperty.all<Color>(const Color(0xFFD1E4FF)),
      headingRowHeight: 56.0,
      horizontalMargin: 0.0,
      columnSpacing: 0.0,
      dividerThickness: 1.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD1E4FF),
          width: 1.0.w,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  static MenuBarThemeData menuBarTheme() {
    return const MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFD1E4FF)),
        elevation: WidgetStatePropertyAll<double>(2.0),
        alignment: Alignment.center,
      ),
    );
  }

  static NavigationBarThemeData navigationBarTheme() {
    return NavigationBarThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      indicatorColor: const Color(0xFF1976D2),
      elevation: 2.0,
      shadowColor: const Color(0xFF000000),
      iconTheme: const WidgetStatePropertyAll<IconThemeData>(
        IconThemeData(
          color: Color(0xFF1976D2),
          size: 24.0,
          opacity: 1.0,
          fill: 1.0,
        ),
      ),
      labelTextStyle: WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          fontSize: 14.0.sp,
          color: const Color(0xFF1976D2),
        ),
      ),
      height: 56.0.h,
    );
  }

  static navigationDrawerTheme() {
    return NavigationDrawerThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      elevation: 2.0,
      shadowColor: const Color(0xFF000000),
      iconTheme: const WidgetStatePropertyAll<IconThemeData>(
        IconThemeData(
          color: Color(0xFF1976D2),
          size: 24.0,
          opacity: 1.0,
          fill: 1.0,
        ),
      ),
      labelTextStyle: WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          fontSize: 14.0.sp,
          color: const Color(0xFF1976D2),
        ),
      ),
    );
  }

  static progressIndicatorTheme() {
    return const ProgressIndicatorThemeData(
      color: Color(0xFF1976D2),
    );
  }

  static navigationRailTheme() {
    return NavigationRailThemeData(
      backgroundColor: const Color(0xFFD1E4FF),
      elevation: 2.0,
      selectedIconTheme: const IconThemeData(
        color: Color(0xFF1976D2),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      selectedLabelTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF1976D2),
      ),
      unselectedIconTheme: const IconThemeData(
        color: Color(0xFF1976D2),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      unselectedLabelTextStyle: TextStyle(
        fontSize: 14.0.sp,
        color: const Color(0xFF1976D2),
      ),
      minWidth: 72.0.w,
      groupAlignment: 0.0,
      labelType: NavigationRailLabelType.none,
    );
  }

  static TimePickerThemeData timePickerTheme() {
    return TimePickerThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      hourMinuteTextColor: const Color(0xFF1976D2),
      hourMinuteColor: const Color(0xFFF8F8F8),
      dayPeriodTextColor: const Color(0xFF1976D2),
      dayPeriodColor: const Color(0xFFF8F8F8),
      dialHandColor: const Color(0xFF1976D2),
      dialBackgroundColor: const Color(0xFFD1E4FF),
      dialTextColor: const Color(0xFF1976D2),
      entryModeIconColor: const Color(0xFF1976D2),
      hourMinuteTextStyle:
          TextStyle(fontSize: 24.0.sp, color: const Color(0xFF1976D2)),
      dayPeriodTextStyle:
          TextStyle(fontSize: 24.0.sp, color: const Color(0xFF1976D2)),
      helpTextStyle:
          TextStyle(fontSize: 24.0.sp, color: const Color(0xFF1976D2)),
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xFFF8F8F8), iconColor: Color(0xFFACACAC)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
