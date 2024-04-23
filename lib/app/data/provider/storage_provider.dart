import 'package:get_storage/get_storage.dart';

class StorageProvider {
  static write(key, String value) async {
    await GetStorage().write(key, value);
  }

  static writeBool(key, bool value) async {
    await GetStorage().write(key, value);
  }

  static read(key) {
    try {
      return GetStorage().read(key);
    } catch (e) {
      return "";
    }
  }

  static void clearAll() {
    GetStorage().erase();
  }

  static deleteStorage(key) async {
    await GetStorage().remove(key);
  }
}

class StorageKey {
  static const String status = "status";
  static const String idUser = "idUser";
  static const String role = "role";
  static const String profilePicture = "profilePicture";
  static const String email = "email";
  static const String username = "username";
  static const String rememberMe = "rememberMe";
  static const String refreshPeminjaman = "refreshPeminjaman";
}
