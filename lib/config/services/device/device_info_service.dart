part of '../services.dart';

mixin DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Returns the Android SDK version as an integer.
  /// For non-Android devices, it returns null.
  static Future<int?> getAndroidSdkVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.version.sdkInt;
    }
    return null;
  }

  /// Checks if the device is running Android 13 or higher
  static Future<bool> isAndroid13OrHigher() async {
    final sdkVersion = await getAndroidSdkVersion();
    return sdkVersion != null && sdkVersion > 32;
  }

  static Future<void> getAllDeviceInfo() async {
    final deviceInfo = await _deviceInfoPlugin.deviceInfo;
    LogDev.warning('deviceInfo: ${deviceInfo.data}');
  }

  static Future<String> get deviceToken async {
    String deviceIdFromLocalStore = await LocalStoreService.getString(key: LocalStoreKey.deviceTokenUID) ?? '';
    if (deviceIdFromLocalStore.isNotEmpty) {
      return deviceIdFromLocalStore;
    }

    String deviceId = '';
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id; // This is a unique ID on Android
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? ''; // Unique ID on iOS
      }
    } catch (e) {
      LogDev.warning('Error getting device info: $e');
    }

    // If we couldn't get a device ID, generate a UUID
    if (deviceId.isEmpty) {
      deviceId = const Uuid().v8();
      await LocalStoreService.setString(key: LocalStoreKey.deviceTokenUID, value: deviceId);
      // You might want to store this generated UUID persistently
      // so it remains consistent across app launches
    }

    return deviceId;
  }
}
