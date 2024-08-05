import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({required this.phoneNumber, Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SignInProvider>(context, listen: false).startTimer();
    });
  }

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String _getOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  Future<void> _verifyOtp() async {
    final otp = _getOtp();
    if (otp.length < 4) {
      showCustomSnackbar(context, "Please enter the full OTP");
      return;
    }

    final signInProvider = Provider.of<SignInProvider>(context, listen: false);

    try {
      await signInProvider.verifyOtp(widget.phoneNumber, otp, context);
    } catch (e) {
      showCustomSnackbar(context, 'Verification failed. Please try again.');
    }
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      //  height: 150,
      width: 76,
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20, // Increase the text size
        ),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: MyColors.lightGrey,
                width: 3.0), // Border color when enabled
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 2.0), // Border color when focused
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 35.0,
          ), // Add vertical padding for height
        ),
        onChanged: (value) async {
          if (value.isNotEmpty && index < otpControllers.length - 1) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }

          if (_getOtp().length == otpControllers.length) {
            await _verifyOtp();
          }
        },
      ),
    );
  }

  void showCustomSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.primary,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    const Text(
                      'Enter The \nCode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'OTP has been sent to your mobile number',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                    color: MyColors.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, _buildOtpBox),
                ),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: signInProvider.start == 0
                        ? () {
                            FocusScope.of(context).unfocus();
                            signInProvider.resetTimer();
                          }
                        : null,
                    child: Text(
                      signInProvider.start == 0
                          ? 'Resend code'
                          : 'Resend code in ${signInProvider.start} s',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: signInProvider.start == 0
                            ? MyColors.grey2
                            : MyColors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
