part of '../services.dart';

class CameraService {
  static List<CameraDescription> cameras = [];
  static int currentCameraIndex = 0;

  static Future<void> initCameras() async {
    try {
      var allCameras = await availableCameras();

      // Remove duplicate cameras by keeping only the first camera of each lens direction
      final uniqueCameras = <CameraDescription>[];
      final seenDirections = <CameraLensDirection>{};

      for (final camera in allCameras) {
        if (!seenDirections.contains(camera.lensDirection)) {
          uniqueCameras.add(camera);
          seenDirections.add(camera.lensDirection);
        }
      }

      cameras = uniqueCameras;
      LogDev.info('CAMERA SERVICE INITIALIZED\r\nThere are ${cameras.length} cameras found\r\nDescriptions: ${cameras.map((e) => e.lensDirection).join(', ')}');

      if (cameras.isEmpty) {
        _handleError('No cameras found');
      }
      currentCameraIndex = 0; // Reset to the first camera
    } catch (e) {
      _handleError('Failed to initialize cameras: $e');
    }
  }

  static Future<bool> requestCameraPermission() async {
    // Check both camera and microphone permissions
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;

    // Return true if both permissions are already granted
    if (cameraStatus.isGranted && microphoneStatus.isGranted) return true;

    // Return false if either permission is permanently denied or restricted
    if (cameraStatus.isPermanentlyDenied || cameraStatus.isRestricted || microphoneStatus.isPermanentlyDenied || microphoneStatus.isRestricted) {
      return false;
    }

    // Request both permissions
    cameraStatus = await Permission.camera.request();
    microphoneStatus = await Permission.microphone.request();

    // Return true only if both permissions are granted
    return cameraStatus.isGranted && microphoneStatus.isGranted;
  }

  static String getCameraPermissionMessage(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Camera permission granted';
      case PermissionStatus.denied:
        return 'Camera permission denied. Please try again and grant access.';
      case PermissionStatus.permanentlyDenied:
        return 'Camera permission permanently denied. Please enable in app settings.';
      case PermissionStatus.restricted:
        return 'Camera permission restricted. Please check your device settings.';
      default:
        return 'Unknown camera permission status';
    }
  }

  static Future<CameraController?> initializeCamera() async {
    if (!await requestCameraPermission()) {
      _handleError('Camera permission not granted');
      return null;
    }
    if (cameras.isEmpty) {
      await initCameras(); // Ensure cameras are initialized
    }
    if (cameras.isEmpty) {
      _handleError('No cameras available');
      return null;
    }
    try {
      final camera = cameras[currentCameraIndex];
      final controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: true,
      );
      await controller.initialize();
      await controller.prepareForVideoRecording();
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      return controller;
    } catch (e) {
      _handleError('Failed to initialize camera: $e');
      return null;
    }
  }

  static Future<File?> takePicture(CameraController controller) async {
    if (!controller.value.isInitialized) {
      _handleError('Camera not initialized');
      return null;
    }
    try {
      final XFile file = await controller.takePicture();
      final savedPicture = await savePicture(file);
      return savedPicture;
    } catch (e) {
      _handleError('Failed to take picture: $e');
      return null;
    }
  }

  static Future<File> savePicture(XFile file) async {
    try {
      final fileName = file.path.split('/').last;
      final picturePath = await fileName.appImages;
      final savedPicture = await File(file.path).copy(picturePath);
      return savedPicture;
    } catch (e) {
      _handleError('Failed to save picture: $e');
      return File('');
    }
  }

  static Future<void> startVideoRecording(CameraController controller) async {
    if (!controller.value.isInitialized) {
      _handleError('Camera not initialized');
      return;
    }
    try {
      await controller.startVideoRecording();
    } catch (e) {
      _handleError('Failed to start video recording: $e');
    }
  }

  static Future<String> stopVideoRecording(CameraController controller) async {
    if (!controller.value.isInitialized) {
      _handleError('Camera not initialized');
      return '';
    }
    try {
      final XFile file = await controller.stopVideoRecording();
      // Save the video to the app's private directory
      final savedVideo = await saveVideo(file);
      return savedVideo.path;
    } catch (e) {
      _handleError('Failed to stop video recording: $e');
      return '';
    }
  }

  static Future<File> saveVideo(XFile file) async {
    try {
      final fileName = file.path.split('/').last;
      final videoPath = await fileName.appVideos;
      final savedVideo = await File(file.path).copy(videoPath);

      // Verify the file exists
      if (!await savedVideo.exists()) {
        throw Exception('Video file was not saved successfully');
      }

      return savedVideo;
    } catch (e) {
      _handleError('Error saving video: $e');
      return File('');
    }
  }

  static Future<void> toggleFlash(CameraController controller) async {
    if (!controller.value.isInitialized) {
      _handleError('Camera not initialized');
      return;
    }
    try {
      final newMode = controller.value.flashMode != FlashMode.torch ? FlashMode.torch : FlashMode.off;
      await controller.setFlashMode(newMode);
    } catch (e) {
      _handleError('Failed to toggle flash: $e');
    }
  }

  static Future<CameraController?> switchCamera(CameraController controller) async {
    if (!controller.value.isInitialized) {
      _handleError('Camera not initialized');
      return null;
    }
    try {
      if (cameras.length < 2) {
        _handleError('No alternative camera found');
        return null;
      }
      currentCameraIndex = (currentCameraIndex + 1) % cameras.length;
      final newCamera = cameras[currentCameraIndex];
      await controller.setDescription(newCamera);
      return controller;
    } catch (e) {
      _handleError('Failed to switch camera: $e');
      return null;
    }
  }

  static CameraDescription? getCurrentCamera() {
    return cameras.isNotEmpty ? cameras[currentCameraIndex] : null;
  }

  static bool isRearCamera() {
    final currentCamera = getCurrentCamera();
    return currentCamera?.lensDirection == CameraLensDirection.back;
  }

  static bool isFrontCamera() {
    final currentCamera = getCurrentCamera();
    return currentCamera?.lensDirection == CameraLensDirection.front;
  }

  static void _handleError(String message) {
    LogDev.error('CameraHelper Error: $message');
  }
}
