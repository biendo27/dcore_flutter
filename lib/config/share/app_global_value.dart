part of 'share.dart';

mixin AppGlobalValue {
  static Size get uiSize => MediaQuery.sizeOf(AppConfig.context!);
  static int affiliateId = 0;
  static const Size designSize = Size(390, 844);
  static ThemeData appTheme = ThemeData();
  static String accessToken = '';
  static String refreshToken = '';
  static String firebaseToken = '';
}
