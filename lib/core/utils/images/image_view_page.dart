part of '../utils.dart';

class ImageViewPage extends StatelessWidget {
  final String url;

  const ImageViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: url.startsWith('http')
                ? CachedNetworkImageProvider(url)
                : url.startsWith('/')
                    ? FileImage(File(url)) as ImageProvider
                    : AssetImage(url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}