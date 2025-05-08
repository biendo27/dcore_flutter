part of '../services.dart';

class MediaService {
  static Future<bool> requestMediaPermission() async {
    if (Platform.isIOS) {
      // Request storage library permission
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted || storageStatus.isLimited) return true;
      if (storageStatus.isPermanentlyDenied || storageStatus.isRestricted) return false;

      final requestedStatus = await Permission.storage.request();
      return requestedStatus.isGranted || requestedStatus.isLimited;
    }

    late Permission permission;
    if (await DeviceInfoService.isAndroid13OrHigher()) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }

    PermissionStatus status = await permission.status;
    if (status.isGranted || status.isLimited) return true;
    if (status.isPermanentlyDenied || status.isRestricted) return false;

    status = await permission.request();
    return status.isGranted || status.isLimited;
  }

  // Delegate to ImageHelper
  static Future<File?> saveImage(File image, String fileName) => _ImageService.saveImage(image, fileName);

  static Future<File?> getImage(String fileName) => _ImageService.getImage(fileName);

  static Future<bool> deleteImage(String fileName) => _ImageService.deleteImage(fileName);

  static Future<File?> pickImage({bool fromCamera = false}) => _ImageService.pickImage(fromCamera: fromCamera);
  static Future<File?> captureImage() => _ImageService.captureImage();
  static Future<List<File>> pickMultipleImages() => _ImageService.pickMultipleImages();

  // Delegate to VideoHelper
  static Future<File?> saveVideo(File video, String fileName) => _VideoService.saveVideo(video, fileName);

  static Future<File?> getVideo(String fileName) => _VideoService.getVideo(fileName);

  static Future<bool> deleteVideo(String fileName) => _VideoService.deleteVideo(fileName);

  static Future<File?> pickVideo({bool fromCamera = false}) => _VideoService.pickVideo(fromCamera: fromCamera);

  static Future<List<File>> pickMultipleVideos() => _VideoService.pickMultipleVideos();

  static Future<XFile?> getVideoThumbnail(String videoPath) => _VideoService.getVideoThumbnail(videoPath);

  static Future<String> getVideoThumbnailPath(String videoPath) => _VideoService.getVideoThumbnailPath(videoPath);

  static Future<String> mixAudioToVideo({
    required String localVideoPath,
    required String remoteAudioUrl,
  }) =>
      _VideoService.mixNetworkAudioWithLocalVideo(
        localVideoPath: localVideoPath,
        remoteAudioUrl: remoteAudioUrl,
      );

  // Delegate to AudioHelper
  static Future<File?> saveAudio(File audio, String fileName) => _AudioHelper.saveAudio(audio, fileName);
  static Future<File?> getAudio(String fileName) => _AudioHelper.getAudio(fileName);
  static Future<bool> deleteAudio(String fileName) => _AudioHelper.deleteAudio(fileName);
  static Future<File?> pickAudio() => _AudioHelper.pickAudio();
  static Future<List<File>> pickMultipleAudios() => _AudioHelper.pickMultipleAudios();
  static Future<File?> getAudioFromVideoPath(String videoPath) => _AudioHelper.getAudioFromVideoPath(videoPath);
}

class _ImageService {
  static Future<File?> saveImage(File image, String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return null;
    }
    try {
      final savedImage = await image.copy(await fileName.appImages);
      return savedImage;
    } catch (e) {
      FileService._handleError('Failed to save image: $e');
      return null;
    }
  }

  static Future<File?> getImage(String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return null;
    }
    try {
      final file = File(await fileName.appImages);
      if (await file.exists()) {
        return file;
      } else {
        FileService._handleError('Image not found');
        return null;
      }
    } catch (e) {
      FileService._handleError('Failed to get image: $e');
      return null;
    }
  }

  static Future<bool> deleteImage(String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return false;
    }
    try {
      final file = File(await fileName.appImages);
      if (await file.exists()) {
        await file.delete();
        return true;
      } else {
        FileService._handleError('Image not found');
        return false;
      }
    } catch (e) {
      FileService._handleError('Failed to delete image: $e');
      return false;
    }
  }

  static Future<File?> pickImage({bool fromCamera = false}) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return null;
    }
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      FileService._handleError('Failed to pick image: $e');
      return null;
    }
  }

  static Future<List<File>> pickMultipleImages() async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return [];
    }
    try {
      final picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage();
      return pickedFiles.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      FileService._handleError('Failed to pick images: $e');
      return [];
    }
  }

  static Future<File?> captureImage() async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return null;
    }
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      FileService._handleError('Failed to capture image: $e');
      return null;
    }
  }
}

class _VideoService {
  static Future<File?> saveVideo(File video, String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return null;
    }
    try {
      final savedVideo = await video.copy(await fileName.appVideos);
      return savedVideo;
    } catch (e) {
      FileService._handleError('Failed to save video: $e');
      return null;
    }
  }

  static Future<File?> getVideo(String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return null;
    }
    try {
      final file = File(await fileName.appVideos);
      if (await file.exists()) {
        return file;
      } else {
        FileService._handleError('Video not found');
        return null;
      }
    } catch (e) {
      FileService._handleError('Failed to get video: $e');
      return null;
    }
  }

  static Future<XFile?> getVideoThumbnail(String videoPath) async {
    if (videoPath.isEmpty) return null;
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      timeMs: 1000,
      maxHeight: 100.h.toInt(),
      quality: 75,
    );

    return thumbnail;
  }

  static Future<String> getVideoThumbnailPath(String videoPath) async {
    XFile? thumbnail = await getVideoThumbnail(videoPath);
    LogDev.warning('thumbnail: ${thumbnail?.path}');
    return thumbnail?.path ?? '';
  }

  static Future<bool> deleteVideo(String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return false;
    }
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/$fileName');
      if (await file.exists()) {
        await file.delete();
        return true;
      } else {
        FileService._handleError('Video not found');
        return false;
      }
    } catch (e) {
      FileService._handleError('Failed to delete video: $e');
      return false;
    }
  }

  static Future<File?> pickVideo({bool fromCamera = false}) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return null;
    }
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      FileService._handleError('Failed to pick video: $e');
      return null;
    }
  }

  static Future<List<File>> pickMultipleVideos() async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Photos permission not granted');
      return [];
    }
    try {
      final picker = ImagePicker();
      // Note: ImagePicker doesn't have a direct pickMultipleVideos method
      // This is a workaround using pickVideo multiple times
      final List<File> videos = [];
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        videos.add(File(pickedFile.path));
      }
      return videos;
    } catch (e) {
      FileService._handleError('Failed to pick videos: $e');
      return [];
    }
  }

  static Future<String> mixNetworkAudioWithLocalVideo({required String localVideoPath, required String remoteAudioUrl}) async {
    if (localVideoPath.isEmpty || remoteAudioUrl.isEmpty) return '';
    
    // Step 1: Download the remote audio to a local path using Dio
    final downloadedAudioPath = await StorageService.downloadFile(remoteAudioUrl, 'audio.mp3');
    String outputPath = await 'output_video.mp4'.appOutput;
    // Step 2: Build your FFmpeg command

    final String ffmpegCommand = '-i $localVideoPath -i $downloadedAudioPath -y -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest $outputPath';

    LogDev.one("Executing FFmpeg command:\n$ffmpegCommand");

    // Step 3: Execute the FFmpeg command using FFmpegKit
    // final session = await FFmpegKit.execute(ffmpegCommand);
    // final returnCode = await session.getReturnCode();
    // // Step 4: Check results
    // if (ReturnCode.isSuccess(returnCode)) {
    //   // SUCCESS
    //   LogDev.one('FFmpeg: merging was successful. Output: $outputPath');
    // } else if (ReturnCode.isCancel(returnCode)) {
    //   // CANCEL
    //   LogDev.one('FFmpeg operation was cancelled.');
    // } else {
    //   // ERROR
    //   LogDev.one('FFmpeg execution failed with rc=${returnCode?.getValue()}');
    //   final logs = await session.getAllLogsAsString();
    //   LogDev.one('FFmpeg error logs: $logs');
    // }

    return outputPath;
  }
}

class _AudioHelper {
  static Future<File?> saveAudio(File audio, String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Storage permission not granted');
      return null;
    }
    try {
      final savedAudio = await audio.copy(await fileName.appAudios);
      if (!await savedAudio.exists()) {
        throw Exception('Audio file was not saved successfully');
      }
      return savedAudio;
    } catch (e) {
      FileService._handleError('Failed to save audio: $e');
      return null;
    }
  }

  static Future<File?> getAudio(String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Storage permission not granted');
      return null;
    }
    try {
      final file = File(await fileName.appAudios);
      if (await file.exists()) {
        return file;
      } else {
        FileService._handleError('Audio not found');
        return null;
      }
    } catch (e) {
      FileService._handleError('Failed to get audio: $e');
      return null;
    }
  }

  static Future<bool> deleteAudio(String fileName) async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Storage permission not granted');
      return false;
    }
    try {
      final file = File(await fileName.appAudios);
      if (await file.exists()) {
        await file.delete();
        return true;
      } else {
        FileService._handleError('Audio not found');
        return false;
      }
    } catch (e) {
      FileService._handleError('Failed to delete audio: $e');
      return false;
    }
  }

  static Future<File?> pickAudio() async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Storage permission not granted');
      return null;
    }
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
      return null;
    } catch (e) {
      FileService._handleError('Failed to pick audio: $e');
      return null;
    }
  }

  static Future<List<File>> pickMultipleAudios() async {
    if (!await MediaService.requestMediaPermission()) {
      FileService._handleError('Storage permission not granted');
      return [];
    }
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.where((file) => file.path != null).map((file) => File(file.path!)).toList();
      }
      return [];
    } catch (e) {
      FileService._handleError('Failed to pick audios: $e');
      return [];
    }
  }

  static Future<File?> getAudioFromVideoPath(String videoPath) async {
    try {
      if (videoPath.isEmpty) {
        FileService._handleError('Video path is empty');
        return null;
      }

      final videoFile = File(videoPath);
      if (!await videoFile.exists()) {
        FileService._handleError('Video file not found');
        return null;
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'audio_$timestamp.mp3';
      final audioPath = await fileName.appAudios;

      // Create audio file from video
      final audioFile = await videoFile.copy(audioPath);
      if (!await audioFile.exists()) {
        throw Exception('Audio extraction failed');
      }

      return audioFile;
    } catch (e) {
      FileService._handleError('Failed to extract audio from video: $e');
      return null;
    }
  }
}
