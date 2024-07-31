import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodstorefront/api_service.dart';
import 'package:foodstorefront/provider/user_provider.dart';
import 'package:foodstorefront/screens/location/location_access_screen.dart';
import 'package:foodstorefront/screens/store/store_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignInViewProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  bool isOTPVerified = false; // Controls OTP field visibility in UI
  bool? isUserRegistered; // Tracks if user is registered
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> verifyPhoneNumber(BuildContext context) async {
    String? token = await _secureStorage.read(key: 'token');
    if (phoneController.text.isEmpty || phoneController.text.length < 11) {
      _showSnackBar(context, 'Please enter a valid phone number.');
      return;
    }

    var response = await http.post(
      Uri.parse("${ApiService.baseUrlforAuth}/send-otp-consumer"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "mobile_no": "+92${phoneController.text.trim()}",
      }),
    );
    print("  response: ${response}");
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print("  verifyPhoneNumber: ${responseData}");
      _showSnackBar(context, responseData['message'], Colors.green);
      isUserRegistered = responseData['data']['user'];
      isOTPVerified = true;
      notifyListeners();
    } else {
      _showServerError(context, response.body);
    }
  }

  void verifyOTP(BuildContext context) async {
    String? token = await _secureStorage.read(key: 'token');
    var response = await http.post(
      Uri.parse("${ApiService.baseUrlforAuth}/login-consumer"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "mobile_no": "+92" + phoneController.text.trim(),
        "otp": otpController.text,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['status']) {
        if (responseData['user'] != null) {
          int userId = responseData['user']['id'];
          //  String userName = responseData['user']['name'];
          String firstName = responseData['user']['first_name'];
          String lastName = responseData['user']['last_name'];
          String token = responseData['user']['api_token'] ?? '';

          // Ensuring userId is valid
          if (userId > 0) {
            // Update UserProvider for a registered user
            Provider.of<UserProvider>(context, listen: false)
                .updateUserAfterOTP(
              '$firstName $lastName',
              userId,
              token,
            );
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const StoreScreen()));
          } else {
            _showSnackBar(context, 'Invalid user ID received.', Colors.red);
          }
        } else {
          // Handle unregistered user scenario
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LocationAccessScreen()));
        }
      } else {
        // OTP verification failed
        _showSnackBar(
            context,
            responseData['message'] ?? 'Invalid OTP, please try again.',
            Colors.red);
      }
    } else {
      // Handle HTTP errors
      _showServerError(context, response.body);
    }
  }

  // Show Message
  void _showSnackBar(BuildContext context, String message,
      [Color color = Colors.red]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8), // Space between the icon and text
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Show Error Message
  void _showServerError(BuildContext context, String message) {
    _showSnackBar(context, 'Server error: $message');
  }
}
