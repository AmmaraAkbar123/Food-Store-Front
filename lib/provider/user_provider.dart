// // user_model.dart
// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String mobile;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.mobile,
//   });

//   // Convert a UserModel into a Map. The keys must correspond to the names of the
//   // fields in the JSON object.
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'email': email,
//         'mobile': mobile,
//       };

//   // Extract a UserModel from a Map.
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json['id'],
//         name: json['name'],
//         email: json['email'],
//         mobile: json['mobile'],
//       );
// }

 

  
// // class UserProvider with ChangeNotifier {
// //   final PreferencesService _prefsService = PreferencesService();
// //   User _user = User();

// //   User get user => _user;

// //   UserProvider() {
// //     _initializeUser();
// //   }

// //   Future<void> _initializeUser() async {
// //     await loadUserFromPrefs();
// //     await checkLoginStatus();
// //   }

// //   Future<void> checkLoginStatus() async {
// //     String? token = await AuthenticationService.getToken();
// //     if (token != null && _user.isOTPVerified) {
// //       _user.isLoggedIn = true;
// //     } else {
// //       _user.isLoggedIn = false;
// //     }
// //     notifyListeners();
// //   }

// //   void login(String name, int userId, String token) async {
// //     _user.name = name;
// //     _user.userId = userId;
// //     _user.isLoggedIn = true;
// //     await AuthenticationService.saveToken(token);
// //     await saveUserToPrefs();
// //     notifyListeners();
// //   }

// //   void verifyOTP() {
// //     _user.isOTPVerified = true;
// //     saveUserToPrefs(); // Save the updated OTP verification status
// //     notifyListeners();
// //   }

// //   void updateUserAfterOTP(String name, int userId, String token) async {
// //     _user.name = name;
// //     _user.userId = userId;
// //     _user.isOTPVerified = true;
// //     _user.isLoggedIn = token.isNotEmpty;
// //     if (token.isNotEmpty) {
// //       await AuthenticationService.saveToken(token);
// //     }
// //     await saveUserToPrefs();
// //     notifyListeners();
// //   }

// //   void logout() async {
// //     await AuthenticationService.deleteToken();
// //     _user = User(); // Reset user to default state
// //     await clearUserFromPrefs();
// //     notifyListeners();
// //   }

// //   Future<void> saveUserToPrefs() async {
// //     String userJson = json.encode(_user.toJson());
// //     print('Saving User: $userJson'); // Debug statement
// //     await _prefsService.save('user', userJson);
// //   }

// //   Future<void> loadUserFromPrefs() async {
// //     String? userJson = await _prefsService.load('user');
// //     print('Loaded User JSON: $userJson'); // Debug statement
// //     if (userJson != null) {
// //       _user = User.fromJson(json.decode(userJson));
// //       notifyListeners();
// //     }
// //     await checkLoginStatus();
// //   }

// //   Future<void> clearUserFromPrefs() async {
// //     await _prefsService.remove('user');
// //   }
// // }
