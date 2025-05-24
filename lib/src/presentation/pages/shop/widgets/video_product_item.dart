part of '../shop.dart';

class VideoProductItem extends StatelessWidget {
  const VideoProductItem({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: 180.w,
        child: Stack(
          children: [
            DCachedImage(
              borderRadius: BorderRadius.circular(10.r),
              url: AppAsset.images.myWife.path,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Positioned(
              bottom: 2,
              left: 8.w,
              right: 8.w,
              child: SizedBox(
                width: 170.w,
                height: 35.h,
                child: AppText(
                  "Xin chào mọi người, Xin chào mọi người,Xin chào mọi người,Xin chào mọi người, ",
                  style: AppStyle.text12.copyWith(
                    color: AppColorLight.surface,
                    shadows: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
