import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  static const String _tokenKey = 'token';
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Save token
  static Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  // Retrieve token
  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Delete token
  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
