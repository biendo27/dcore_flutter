part of '../utils.dart';

class DCachedImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxDecoration? decoration;
  final BoxFit fit;
  final bool enablePhotoView;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final void Function()? onTap;
  final void Function()? onDoubleTap;

  const DCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.decoration,
    this.enablePhotoView = false,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.onTap,
    this.onDoubleTap,
  });

  void _showImageViewer(BuildContext context) {
    context.pushNamed(RouteNamed.imageView, extra: url);
  }

  void _onTap(BuildContext context) {
    if (enablePhotoView) {
      _showImageViewer(context);
      return;
    }
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildImage();

    child = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      child: child,
    );

    if (margin != EdgeInsets.zero || padding != EdgeInsets.zero || decoration != null) {
      child = Container(
        margin: margin,
        padding: padding,
        decoration: decoration,
        child: child,
      );
    }

    if (onTap != null || enablePhotoView) {
      child = InkWell(
        onTap: () => _onTap(context),
        child: child,
      );
    }

    if (onDoubleTap != null) {
      child = InkWell(
        onDoubleTap: onDoubleTap,
        child: child,
      );
    }

    return child;
  }

  Widget _buildImage() {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        width: width,
        height: height,
        progressIndicatorBuilder: _buildProgressIndicator,
        errorWidget: (_, __, ___) => const Icon(FontAwesomeIcons.circleExclamation),
      );
    }

    if (url.startsWith('/')) {
      return Image.file(
        File(url),
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => const Icon(FontAwesomeIcons.circleExclamation),
      );
    }

    return Image.asset(
      url,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, __, ___) => const Icon(FontAwesomeIcons.circleExclamation),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, String url, DownloadProgress download) {
    if (download.progress != null) {
      return Center(
        child: AppText(
          '${(download.progress! * 100).toStringAsFixed(0)}%',
          style: AppStyle.textBold16,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(10).w,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
