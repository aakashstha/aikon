import 'package:get_storage/get_storage.dart';

class StorageGetX {
  static Future<void> initializeStorageGetX() async {
    await GetStorage.init();
  }

  static Future<void> writeFirebaseToken(String token) async {
    await GetStorage().write("firebase_token", token);
  }

  static Future<dynamic> readFirebaseToken() async {
    return await GetStorage().read("firebase_token");
  }

  static Future<void> removeData(String key) async {
    await GetStorage().remove(key);
  }

  static Future<void> clearData() async {
    await GetStorage().erase();
  }
}
