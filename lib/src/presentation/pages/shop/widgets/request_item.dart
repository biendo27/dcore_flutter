part of '../shop.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({super.key, required this.imgage, required this.title});
  final String imgage;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(imgage, width: 40.w, height: 40.w),
          10.verticalSpace,
          AppText(
            title,
            maxLines: 3,
            style: AppStyle.text12.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
