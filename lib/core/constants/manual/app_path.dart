part of '../constants.dart';

mixin AppPath {
  static const String videoThumbnail = 'video_thumbnail';
  static const String appImages = 'images';
  static const String appVideos = 'videos';
  static const String appAudios = 'audio';
  static const String appOutput = 'output';
}

class AppPathHelper {
  static Future<String> get localPath async {
    Directory? appDir;

    if (Platform.isAndroid) {
      appDir = await getExternalStorageDirectory();
      return appDir?.path ?? '';
    }

    appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }

  static Future<String> get localPathWithSeparator async {
    String localPathTmp = await localPath;
    return '$localPathTmp${Platform.pathSeparator}';
  }
}

extension AppPathExtension on String {
  Future<String> get videoThumbnail async {
    String videoDir = '${await AppPathHelper.localPathWithSeparator}${AppPath.videoThumbnail}';
    String pathResult = '${videoDir}_$this';
    LogDev.warning('videoThumbnail: $pathResult');
    return pathResult;
  }

  Future<String> get appImages async {
    String imagesDir = '${await AppPathHelper.localPathWithSeparator}${AppPath.appImages}';
    String pathResult = '${imagesDir}_$this';
    LogDev.warning('appImages: $pathResult');
    return pathResult;
  }

  Future<String> get appVideos async {
    String videosDir = '${await AppPathHelper.localPathWithSeparator}${AppPath.appVideos}';
    String pathResult = '${videosDir}_$this';
    LogDev.warning('appVideos: $pathResult');
    return pathResult;
  }

  Future<String> get appAudios async {
    String audioDir = '${await AppPathHelper.localPathWithSeparator}${AppPath.appAudios}';
    String pathResult = '${audioDir}_$this';
    LogDev.warning('appAudio: $pathResult');
    return pathResult;
  }

  Future<String> get appOutput async {
    String outputDir = '${await AppPathHelper.localPathWithSeparator}${AppPath.appOutput}';
    String pathResult = '${outputDir}_$this';
    LogDev.warning('appOutput: $pathResult');
    return pathResult;
  }
}
