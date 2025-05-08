part of '../services.dart';

mixin StorageService {
  static Future<void> saveImageToGallery(Uint8List imageBytes) async {
    try {
      // Save to temporary file first
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp_image.png');
      await file.writeAsBytes(imageBytes);

      // Check and request permissions if needed
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      // Save to gallery using gal
      await Gal.putImage(file.path);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Uint8List?> captureWidget(
    ScreenshotController controller, {
    Duration delay = const Duration(milliseconds: 10),
    double? pixelRatio,
  }) async {
    try {
      return await controller.capture(
        delay: delay,
        pixelRatio: pixelRatio,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> captureAndSaveWidget(
    ScreenshotController controller, {
    Duration delay = const Duration(milliseconds: 10),
    double? pixelRatio,
  }) async {
    try {
      final imageBytes = await captureWidget(
        controller,
        delay: delay,
        pixelRatio: pixelRatio,
      );

      if (imageBytes == null) {
        throw Exception('Failed to capture widget');
      }

      await saveImageToGallery(imageBytes);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> shareWidget(
    ScreenshotController controller, {
    Duration delay = const Duration(milliseconds: 10),
    double? pixelRatio,
    String fileName = 'share_image.png',
  }) async {
    try {
      final imageBytes = await captureWidget(
        controller,
        delay: delay,
        pixelRatio: pixelRatio,
      );

      if (imageBytes == null) {
        throw Exception('Failed to capture widget');
      }

      // Create temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(imageBytes);

      // Share the file
      await SharePlus.instance.share(
        ShareParams(
          text: 'Share QR Code',
          files: [XFile(file.path)],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> saveVideoToGallery(String videoPath) async {
    try {
      // Check and request permissions if needed
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      // Save to gallery using gal
      await Gal.putVideo(videoPath);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> shareVideo({
    required String videoPath,
    String fileName = 'share_video.mp4',
  }) async {
    try {
      // Share the file directly since we already have the path
      await SharePlus.instance.share(
        ShareParams(
          text: 'Share Video',
          files: [XFile(videoPath)],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> saveVideoFromNetwork(
    String url, {
    void Function(int received, int total)? onProgress,
    void Function(String message)? onError,
    void Function()? onSuccess,
  }) async {
    try {
      final tempPath = await downloadFile(url, 'downloaded_video.mp4', onProgress: onProgress);
      final file = File(tempPath);

      // Save to gallery
      await saveVideoToGallery(file.path);

      // Clean up temporary file
      if (await file.exists()) {
        await file.delete();
      }

      onSuccess?.call();
    } catch (e) {
      onError?.call(e.toString());
      rethrow;
    }
  }

  static Future<String> downloadFile(
    String url,
    String fileName, {
    void Function(int received, int total)? onProgress,
  }) async {
    try {
      final dio = Dio();
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/$fileName';

      await dio.download(
        url,
        tempPath,
        onReceiveProgress: onProgress,
      );

      return tempPath;
    } catch (e) {
      rethrow;
    }
  }
}
