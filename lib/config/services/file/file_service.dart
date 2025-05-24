part of '../services.dart';

class FileService {
  static void _handleError(String message) {
    if (kDebugMode) {
      throw Exception(message);
    }
  }

  static Future<bool> requestStoragePermission() async {
    // Check current status
    PermissionStatus status = await Permission.storage.status;

    // If already granted, return true
    if (status.isGranted) return true;

    // If denied, request permission
    if (status.isDenied) {
      status = await Permission.storage.request();
      return status.isGranted;
    }

    // If permanently denied or restricted, we can't request again, so return false
    if (status.isPermanentlyDenied || status.isRestricted) return false;

    // If we get here, it's an unknown case, so we'll try requesting
    status = await Permission.storage.request();
    return status.isGranted;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/files/$fileName');
  }

  static Future<File> writeFile(String fileName, String content) async {
    if (!await requestStoragePermission()) {
      _handleError('Storage permission not granted');
      return File('');
    }
    final file = await _localFile(fileName);
    return file.writeAsString(content);
  }

  static Future<String> readFile(String fileName) async {
    if (!await requestStoragePermission()) {
      _handleError('Storage permission not granted');
      return '';
    }
    try {
      final file = await _localFile(fileName);
      return await file.readAsString();
    } catch (e) {
      return '';
    }
  }

  static Future<bool> deleteFile(String fileName) async {
    if (!await requestStoragePermission()) {
      _handleError('Storage permission not granted');
      return false;
    }
    try {
      final file = await _localFile(fileName);
      await file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> fileExists(String fileName) async {
    if (!await requestStoragePermission()) {
      _handleError('Storage permission not granted');
      return false;
    }
    final file = await _localFile(fileName);
    return file.exists();
  }

  static Future<List<String>> listFiles() async {
    if (!await requestStoragePermission()) {
      _handleError('Storage permission not granted');
      return [];
    }
    final directory = Directory(await _localPath);
    return directory.list().map((entity) => entity.path.split('/').last).toList();
  }

  static Future<File?> pickFile() async {
    if (!await requestStoragePermission()) {
      _handleError('Storage permission not granted');
      return null;
    }
    try {
      final result = await FilePicker.platform.pickFiles();
      return result?.files.single.path != null ? File(result!.files.single.path!) : null;
    } catch (e) {
      _handleError('Failed to pick file: $e');
      return null;
    }
  }

  static Future<List<File>> pickMultipleFiles() async {
    if (!await requestStoragePermission()) {
      _handleError('Storage permission not granted');
      return [];
    }
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      return result?.paths.whereType<String>().map(File.new).toList() ?? [];
    } catch (e) {
      _handleError('Failed to pick files: $e');
      return [];
    }
  }
}
