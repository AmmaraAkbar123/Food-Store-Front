import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';

import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final VoidCallback onBack;

  const OTPScreen({required this.onBack, Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late Timer _timer;
  int _start = 60;
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    startTimer();
    _controllers.forEach((controller) {
      controller.addListener(_onTextChanged);
    });
  }

  void startTimer() {
    _start = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _onTextChanged() {
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.length == 1) {
        if (i < _controllers.length - 1) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      }
    }
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _timer.cancel();
    super.dispose();
  }

  Future<void> _verifyOTP(BuildContext context) async {
    final signInViewProvider =
        Provider.of<SignInViewProvider>(context, listen: false);
    signInViewProvider.otpController.text =
        _controllers.map((controller) => controller.text).join();
    signInViewProvider.verifyOTP(context);
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < _controllers.length - 1) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus(); // Hide the keyboard
        widget.onBack(); // Call the callback to go back
        return false; // Prevent default back navigation behavior
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus(); // Hide the keyboard
                        widget.onBack();
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // Customize the color
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white, // Customize icon color
                          size: 12.0, // Customize icon size
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'Enter the \nCode',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We have sent a verification code to your phone. Please enter it below.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) => _buildOtpBox(index)),
                ),
                const SizedBox(height: 35),
                Center(
                  child: Text(
                    _start > 0
                        ? 'Resend code in $_start seconds'
                        : 'Resend Code',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                CustomButton(
                  text: 'Verify OTP',
                  onPressed: () => _verifyOTP(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
