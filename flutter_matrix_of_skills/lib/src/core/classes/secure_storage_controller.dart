import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// for future API requests
class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _session = 'access_token';

  static Future setSessionToStorage(String session) async =>
      await _storage.write(key: _session, value: session);

  static Future<String?> getSessionFromStorage() async =>
      await _storage.read(key: _session);

  static Future deleteSessionFromStorage() async =>
      await _storage.delete(key: _session);

  static Future deleteAllData() async =>
      await _storage.deleteAll();

}