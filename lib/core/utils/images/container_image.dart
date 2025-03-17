part of '../utils.dart';

class ContainerImage extends StatelessWidget {
  final double width;
  final double height;
  final ImageProvider image;
  final BoxFit fit;
  final double borderRadius;
  const ContainerImage({super.key, required this.width, required this.height, required this.image, this.fit = BoxFit.cover, this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(borderRadius)), image: DecorationImage(image: image, fit: fit)),
    );
  }
}

