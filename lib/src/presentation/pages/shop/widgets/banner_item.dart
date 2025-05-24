part of '../shop.dart';

class BannerItem extends StatelessWidget {
  final StoreBanner banner;
  final bool isFirst;
  final void Function()? onTap;

  const BannerItem({
    super.key,
    required this.banner,
    this.isFirst = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w, left: isFirst ? 15.w : 0),
      child: DCachedImage(
        height: 130.h,
        url: banner.image,
        borderRadius: BorderRadius.circular(15.r),
        onTap: () async {
          bool canLaunch = await canLaunchUrlString(banner.url);
          if (canLaunch) launchUrlString(banner.url, mode: LaunchMode.externalApplication);
        },
      ),
    );
  }
}
