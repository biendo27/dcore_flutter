part of '../livestream.dart';

class StackedImages extends StatelessWidget {
  final List<String> images;
  final double spacing;
  final double radius;
  final int maxImages;
  final Widget? remainingWidget;

  const StackedImages({
    super.key,
    this.images = const [],
    this.spacing = 12,
    this.radius = 10,
    this.maxImages = 3,
    this.remainingWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    final List<String> displayImages = images.take(maxImages).toList();
    // final int remaining = images.length - maxImages;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // First image
        CircleAvatar(
          radius: radius.sp,
          backgroundImage: CachedNetworkImageProvider(displayImages.first),
          backgroundColor: AppColorLight.surface,
          onBackgroundImageError: (_, __) => const Icon(Icons.person),
        ),

        // Rest of the images
        if (displayImages.length > 1)
          for (var i = 1; i < displayImages.length; i++)
            Positioned(
              right: (i * spacing).w,
              child: CircleAvatar(
                radius: radius.sp,
                backgroundImage: CachedNetworkImageProvider(displayImages[i]),
                backgroundColor: AppColorLight.surface,
                onBackgroundImageError: (_, __) => const Icon(Icons.person),
              ),
            ),

        // Show remaining count if any
        // if (remaining > 0 && remainingWidget != null)
        //   Container(
        //     margin: EdgeInsets.only(left: (displayImages.length * spacing).w),
        //     child: remainingWidget!,
        //   ),
      ],
    );
  }
}
