import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/login%20and%20signup/otp/otp_screen.dart';
import 'package:foodstorefront/screens/store/store_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login and signup/signup/signup_screen.dart';
import 'authentication_service.dart'; // Import the AuthenticationService

class SignInProvider extends ChangeNotifier {
  final SharedPreferences _sharedPreferences;

  SignInProvider(this._sharedPreferences);

  // API URLs
  final String _otpUrl =
      'https://api.myignite.online/connector/api/send-otp-consumer';
  final String _loginUrl =
      'https://api.myignite.online/connector/api/login-consumer';
  final String _signUpUrl =
      'https://api.myignite.online/connector/api/contactapi';

  bool _isLoading = false;
  bool isRegistered = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> sendOtp(String phoneNumber, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    print('Sending OTP for phone number: $phoneNumber');

    try {
      final token = await AuthenticationService.getToken(); // Retrieve token
      print('Retrieved token: $token');

      final response = await http.post(
        Uri.parse(_otpUrl),
        headers: {
          'Content-Type': 'application/json',
          if (token != null)
            'Authorization': 'Bearer $token', // Add token to headers
        },
        body: json.encode({'mobile_no': phoneNumber}),
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      final jsonResponse = json.decode(response.body);
      print('JSON response: $jsonResponse');

      if (response.statusCode == 200) {
        // Check if user is already registered
        if (jsonResponse["data"]["user"] == true) {
          isRegistered = true;
        }
        showCustomSnackbar(context, 'OTP sent successfully');

        if (jsonResponse["status"] = true) {
          // User is already registered, navigate to OTP screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(phoneNumber: phoneNumber),
            ),
          );
        }
      } else {
        _errorMessage = 'Failed to send OTP';
        print(_errorMessage);
        showCustomSnackbar(context, 'Failed to send OTP', isError: true);
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print(_errorMessage);
      showCustomSnackbar(context, 'An error occurred: $e', isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Second function
  Timer? _timer;
  int _start = 60;

  int get start => _start;

  void startTimer() {
    _start = 60; // Reset timer each time
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        _start--;
        notifyListeners();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    _start = 60;
    notifyListeners();
    startTimer(); // Start timer immediately after reset
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> verifyOtp(
      String phoneNumber, String otp, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    print('Verifying OTP for phone number: $phoneNumber and OTP: $otp');

    try {
      final token = await AuthenticationService.getToken(); // Retrieve token
      print('Retrieved token: $token');

      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add token to headers
        },
        body: json.encode({'mobile_no': phoneNumber, 'otp': otp}),
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      final jsonResponse = json.decode(response.body);
      print('JSON response: $jsonResponse');

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == true) {
          String successMsg = jsonResponse['message']?.toString() ??
              'OTP verified successfully';
          print(successMsg);
          showCustomSnackbar(context, successMsg);

          if (isRegistered == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => StoreScreen()),
            );
          } else if (isRegistered == false) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          }
        } else {
          String errorMsg =
              jsonResponse['message']?.toString() ?? 'OTP verification failed';
          print(errorMsg);
          showCustomSnackbar(context, errorMsg, isError: true);

          // Navigate to signup screen if OTP is invalid
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        }
      } else {
        _errorMessage =
            'OTP verification failed with status code ${response.statusCode}';
        print(_errorMessage);
        showCustomSnackbar(context, _errorMessage!, isError: true);

        // Navigate to signup screen if OTP verification fails with non-200 status
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print(_errorMessage);
      showCustomSnackbar(context, _errorMessage!, isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /////////////////create account

  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String type,
    String mobile,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();
    print('Signing up user: $firstName $lastName');

    try {
      final token = await AuthenticationService.getToken(); // Retrieve token
      print('Retrieved token: $token');

      final response = await http.post(
        Uri.parse(_signUpUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'type': type,
          'mobile': mobile,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        print('JSON response: $jsonResponse');

        if (jsonResponse['data'] != null) {
          showCustomSnackbar(context, 'Sign up successful');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoreScreen()),
          );
        } else {
          _errorMessage = 'Already registered!';
          print(_errorMessage);
          showCustomSnackbar(context, _errorMessage!, isError: true);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => LoginScreen()),
          // );
        }
      } else {
        _errorMessage = 'Already registered!';
        print(_errorMessage);
        showCustomSnackbar(context, _errorMessage!, isError: true);
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print(_errorMessage);
      showCustomSnackbar(context, 'An error occurred: $e', isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /////
  void showCustomSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: isError ? Colors.white : Colors.black),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
