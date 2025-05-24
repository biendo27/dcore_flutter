part of '../profile.dart';

class ShowPhotoView extends StatelessWidget {
  const ShowPhotoView({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => DNavigator.back(context),
          child: Container(
            color: AppColorLight.onSurface.op(0.5),
            child: Center(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(image),
                backgroundDecoration: const BoxDecoration(
                  color: AppColorLight.onSurface,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.close, color: AppColorLight.surface),
            onPressed: () => DNavigator.back(context),
          ),
        ),
      ],
    );
  }
}
