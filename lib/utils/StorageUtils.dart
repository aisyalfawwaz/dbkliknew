import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtils {
  static Future<void> saveTokenToStorage(String token) async {
    final storage = FlutterSecureStorage();

    // Check if a token already exists
    String? existingToken = await storage.read(key: 'token');

    if (existingToken != null && existingToken.isNotEmpty) {
      // Token already exists, overwrite it with the new token
      await storage.write(key: 'token', value: token);
    } else {
      // No token exists, save the new token
      await storage.write(key: 'token', value: token);
    }
  }

  static Future<String?> getTokenFromStorage() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'token');
  }

  // Add more utility functions as needed
}
