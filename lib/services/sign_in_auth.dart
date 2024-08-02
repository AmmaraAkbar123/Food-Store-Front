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
  bool isOTPVerified = false; // Controls OTP field visibility in UI
  bool? isUserRegistered; // Tracks if user is registered
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
/////////////

  Future<void> verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
    String? token = await _secureStorage.read(key: 'token');

    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      _showSnackBar(context, 'Please enter a valid phone number.');
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(
            "https://dev.api.myignite.online/connector/api/send-otp-consumer"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "mobile_no": "${phoneNumber}",
        }),
      );

      print("response statusCode: ${response.statusCode}");
      print("response headers: ${response.headers}");
      print("response body: ${response.body}");

      if (response.statusCode == 200) {
        // Ensure response body is JSON
        try {
          var responseData = jsonDecode(response.body);
          print("responseData: ${responseData}");

          _showSnackBar(context, responseData['message'], Colors.green);

          isUserRegistered = responseData['data']['user'];
          print("isUserRegistered: ${isUserRegistered}");
          isOTPVerified = true;
          notifyListeners();
        } catch (e) {
          print("JSON parsing error: $e");
          _showSnackBar(context, 'Invalid response format.');
        }
      } else {
        print("Unexpected status code: ${response.statusCode}");
        _showSnackBar(context, 'Unexpected response from server.');
      }
    } catch (e) {
      print("Error: $e");
      if (context.mounted) {
        _showSnackBar(context, 'An error occurred. Please try again.');
      }
    }
  }

  //////////
  void verifyOTP(BuildContext context, String phoneNumber, String otp) async {
    String? token = await _secureStorage.read(key: 'token');
    var response = await http.post(
      Uri.parse("${ApiService.baseUrlforAuth}/login-consumer"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "mobile_no": "+92+${phoneNumber.trim()}",
        "otp": otp,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['status']) {
        if (responseData['user'] != null) {
          int userId = responseData['user']['id'];
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LocationAccessScreen()));
        }
      } else {
        _showSnackBar(
            context, 'OTP verification failed. Please try again.', Colors.red);
      }
    } else {
      _showServerError(context, response.body);
    }
  }

  void _showSnackBar(BuildContext context, String message,
      [Color backgroundColor = Colors.red]) {
    if (context.mounted) {
      // Check if context is still valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    }
  }

  void _showServerError(BuildContext context, String responseBody) {
    var responseData = jsonDecode(responseBody);
    _showSnackBar(context, responseData['message'] ?? 'Server error.');
  }
}
