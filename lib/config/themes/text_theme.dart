part of 'themes.dart';

abstract class AppStyle {
  AppStyle();

  static String fontFamily = AppFont.gilroy;

  static TextStyle text6 = TextStyle(
    fontSize: 6.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text8 = TextStyle(
    fontSize: 8.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text10 = TextStyle(
    fontSize: 10.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text12 = TextStyle(
    fontSize: 12.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text13 = TextStyle(
    fontSize: 13.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text14 = TextStyle(
    fontSize: 14.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text16 = TextStyle(
    fontSize: 16.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text18 = TextStyle(
    fontSize: 18.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text20 = TextStyle(
    fontSize: 20.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );
  static TextStyle text22 = TextStyle(
    fontSize: 22.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text24 = TextStyle(
    fontSize: 24.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text26 = TextStyle(
    fontSize: 26.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text28 = TextStyle(
    fontSize: 28.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text30 = TextStyle(
    fontSize: 30.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text32 = TextStyle(
    fontSize: 32.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text36 = TextStyle(
    fontSize: 36.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.normal,
  );

  static TextStyle textCustom = TextStyle(
    fontSize: 100.sp,
    fontFamily: fontFamily,
    color: AppColorLight.scrim,
    // height: 1.5,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle textBold8 = text8.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold10 = text10.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold12 = text12.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold14 = text14.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold16 = text16.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold18 = text18.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold20 = text20.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold22 = text22.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold24 = text24.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold26 = text26.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold28 = text28.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold30 = text30.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold32 = text32.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle textBold36 = text36.copyWith(fontWeight: FontWeight.bold);

  static BoxShadow shadow5 = BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    spreadRadius: 0,
    blurRadius: 20,
    offset: const Offset(0, 4),
  );

  static BoxShadow shadow10 = BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    spreadRadius: 0,
    blurRadius: 20,
    offset: const Offset(0, 4),
  );
}
