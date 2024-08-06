import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/login%20and%20signup/otp/otp_screen.dart';
import 'package:foodstorefront/screens/store/store_screen.dart';
import 'package:foodstorefront/services/share_pref_service.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../screens/login and signup/signup/signup_screen.dart';
import 'authentication_service.dart';

class SignInProvider extends ChangeNotifier {
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

    // Ensure phone number starts with +92
    if (!phoneNumber.startsWith('+92')) {
      phoneNumber = '+92$phoneNumber';
    }

    try {
      final token = await AuthenticationService.getToken();
      print('Retrieved token: $token');

      final response = await http.post(
        Uri.parse(_otpUrl),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode({'mobile_no': phoneNumber}),
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      final jsonResponse = json.decode(response.body);
      print('JSON response: $jsonResponse');

      if (response.statusCode == 200) {
        if (jsonResponse["data"]["user"] == true) {
          isRegistered = true;
        }
        showCustomSnackbar(context, 'OTP sent successfully');

        if (jsonResponse["status"] == true) {
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
      _errorMessage = 'Failed to send OTP. Please try again later.';
      print('An error occurred: $e');
      showCustomSnackbar(context, _errorMessage!, isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Timer? _timer;
  int _start = 60;

  int get start => _start;

  void startTimer() {
    _start = 60;
    _timer?.cancel();
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
    startTimer();
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
      final token = await AuthenticationService.getToken();
      print('Retrieved token: $token');

      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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

          if (jsonResponse['user'] != null) {
            // Extract user data from the response
            final userJson = jsonResponse['user'] as Map<String, dynamic>;
            final user = User.fromJson(userJson);

            // Save user data in SharedPreferences using Cruds provider
            final crudsProvider = Provider.of<Cruds>(context, listen: false);
            await crudsProvider.saveUser(user);

            // User is not null, navigate to StoreScreen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => StoreScreen()),
              (route) => false,
            );
          } else {
            // Navigate to SignUpScreen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
              (route) => false,
            );
          }
        } else {
          String errorMsg =
              jsonResponse['message']?.toString() ?? 'OTP verification failed';
          print(errorMsg);
          showCustomSnackbar(context, errorMsg, isError: true);
        }
      } else {
        _errorMessage =
            'OTP verification failed with status code ${response.statusCode}';
        print(_errorMessage);
        showCustomSnackbar(context, _errorMessage!, isError: true);
      }
    } catch (e) {
      _errorMessage = 'Failed to verify OTP. Please try again later.';
      print('An error occurred: $e');
      showCustomSnackbar(context, _errorMessage!, isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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
      final token = await AuthenticationService.getToken();
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
          await showSuccessScreen(context);
        } else {
          _errorMessage = 'Already registered!';
          print(_errorMessage);
          showCustomSnackbar(context, _errorMessage!, isError: true);
        }
      } else {
        _errorMessage = 'Already registered!';
        print(_errorMessage);
        showCustomSnackbar(context, _errorMessage!, isError: true);
      }
    } catch (e) {
      _errorMessage = 'Failed to sign up. Please try again later.';
      print('An error occurred: $e');
      showCustomSnackbar(context, _errorMessage!, isError: true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> showSuccessScreen(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Account created successfully!")),
            ],
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 3));

    Navigator.of(context).pop(); // Close the dialog

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StoreScreen()),
    );
  }

  Future<void> showLoginSuccess(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                color: MyColors.black,
              ),
              // Container(
              //     margin: EdgeInsets.only(left: 10), child: Text("login!")),
            ],
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 3));

    Navigator.of(context).pop(); // Close the dialog

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StoreScreen()),
    );
  }

  void showCustomSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isError ? Colors.white : Colors.black,
          ),
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
