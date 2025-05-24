part of '../services.dart';

mixin LocalStoreService {
  static FlutterSecureStorage? _storage;

  static void init() async {
    AndroidOptions androidOptions = const AndroidOptions(encryptedSharedPreferences: true);
    IOSOptions iosOptions = const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    _storage = FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
  }

  static Future<void> setString({required String key, required String value}) async {
    await _storage?.write(key: key, value: value);
  }

  static Future<String?> getString({required String key}) async {
    return await _storage?.read(key: key);
  }

  static Future<void> remove({required String key}) async {
    await _storage?.delete(key: key);
  }

  static Future<void> clear() async {
    await _storage?.deleteAll();
  }

  static Future<void> setBool({required String key, required bool value}) async {
    await _storage?.write(key: key, value: value.toString());
  }

  static Future<bool?> getBool({required String key}) async {
    String? value = await _storage?.read(key: key);
    return bool.tryParse(value ?? 'false');
  }

  static Future<void> setInt({required String key, required int value}) async {
    await _storage?.write(key: key, value: value.toString());
  }

  static Future<int?> getInt({required String key}) async {
    String? value = await _storage?.read(key: key);
    return int.tryParse(value ?? '0');
  }

  static Future<void> setDouble({required String key, required double value}) async {
    await _storage?.write(key: key, value: value.toString());
  }

  static Future<double?> getDouble({required String key}) async {
    String? value = await _storage?.read(key: key);
    return double.tryParse(value ?? '0.0');
  }

  static Future<void> setListString({required String key, required List<String> value}) async {
    await _storage?.write(key: key, value: value.join(','));
  }

  static Future<List<String>?> getListString({required String key}) async {
    String? value = await _storage?.read(key: key);
    return value?.split(',');
  }

  static Future<void> setListInt({required String key, required List<int> value}) async {
    await _storage?.write(key: key, value: value.join(','));
  }

  static Future<List<int>?> getListInt({required String key}) async {
    String? value = await _storage?.read(key: key);
    return value?.split(',').map((e) => int.tryParse(e) ?? 0).toList();
  }

  static Future<void> setListDouble({required String key, required List<double> value}) async {
    await _storage?.write(key: key, value: value.join(','));
  }

  static Future<List<double>?> getListDouble({required String key}) async {
    String? value = await _storage?.read(key: key);
    return value?.split(',').map((e) => double.tryParse(e) ?? 0.0).toList();
  }

  static Future<void> setListBool({required String key, required List<bool> value}) async {
    await _storage?.write(key: key, value: value.map((e) => e.toString()).join(','));
  }

  static Future<List<bool>?> getListBool({required String key}) async {
    String? value = await _storage?.read(key: key);
    return value?.split(',').map((e) => bool.tryParse(e) ?? false).toList();
  }
}
