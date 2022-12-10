import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Class
class StorageItem {
  StorageItem(this.key, this.value);

  final String key;
  final String value;
}

class StorageService {
  static final StorageService _storageService = StorageService._internal();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  factory StorageService() {
    return _storageService;
  }

  StorageService._internal();

  static Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
        key: newItem.key, value: newItem.value, aOptions: _getAndroidOptions());
  }

  static Future<String?> readSecureData(String key) async {
    String? readData =
        await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  static Future<void> deleteSecureData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
  }

  static Future<bool> containsKeyInSecureData(String key) async {
    bool containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  static Future<List<StorageItem>> readAllSecureData() async {
    Map<String, String> allData =
        await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list =
        allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }

  static Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
}
