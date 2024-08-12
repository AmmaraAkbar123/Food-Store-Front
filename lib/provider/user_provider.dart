import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodstorefront/models/user_model.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  late final SharedPreferences _sharedPreferences;
  User? _user;

  UserProvider(this._sharedPreferences) {
    _loadUser();
  }

  User? get user => _user;
  int? get userId => _user?.id;


  Future<void> _loadUser() async {
    final userJson = _sharedPreferences.getString('user');
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
      notifyListeners();
    }
  }

  bool isLoggedIn() {
    return _user != null;
  }

  Future<void> saveUser(User user) async {
    _user = user;
    final userJson = jsonEncode(user.toJson());
    await _sharedPreferences.setString('user', userJson);
    notifyListeners();
  }

  Future<void> _removeUser() async {
    _user = null;
    await _sharedPreferences.remove('user');
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await _removeUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen()), // Assuming you have a LoginScreen
    );
  }
}
