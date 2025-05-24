part of '../intro.dart';

class IntroContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  const IntroContent({super.key, required this.imagePath, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DCachedImage(
                url: imagePath,
                width: 1.sw,
              ),
            ),
          ),
        ),
        50.verticalSpace,
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 20.w),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: AppStyle.textBold26.copyWith(color: AppColorLight.onPrimary),
                ),
                20.verticalSpace,
                AppText(
                  description,
                  maxLines: 5,
                  style: AppStyle.text12.copyWith(color: AppColorLight.onPrimary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
