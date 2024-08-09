import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({required this.phoneNumber, super.key});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Delay focus request slightly
      Future.delayed(Duration(milliseconds: 100), () {
        focusNodes[0].requestFocus(); // Automatically focus on the first field
      });
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

  Future<void> _verifyOtp(BuildContext context) async {
    final otp = _getOtp();
    if (otp.length < 4) {
      _showCustomSnackbar(context, "Please enter the full OTP");
      return;
    }

    final signInProvider = Provider.of<SignInProvider>(context, listen: false);

    try {
      await signInProvider.verifyOtp(
        widget.phoneNumber,
        otp,
        context,
      );
    } catch (e) {
      _showCustomSnackbar(context, 'Verification failed. Please try again.');
    }
  }

  void _showCustomSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildOtpBox(int index, double boxWidth, BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Consumer<SignInProvider>(
        builder: (context, signInProvider, child) {
          return TextField(
            cursorColor: MyColors.black,
            controller: otpControllers[index],
            focusNode: focusNodes[index],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40, // Increase the text size
            ),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: otpControllers[index].text.isNotEmpty
                      ? MyColors.black // Border color when text is entered
                      : MyColors.lightGrey, // Border color when empty
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: MyColors.black,
                  width: 1.5, // Border color when focused
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 25.0,
              ), // Add vertical padding for height
            ),
            onChanged: (value) async {
              signInProvider.updateOtp(index, value);
              if (value.isNotEmpty && index < otpControllers.length - 1) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }

              if (_getOtp().length == otpControllers.length) {
                await _verifyOtp(context);
              }
            },
          );
        },
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 50),
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
                  const Text(
                    'Enter The \nCode',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 35, height: 1),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We've sent a verification code to your number. \nPlease enter it below",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 35),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate the width for each OTP box
                      double boxWidth = (constraints.maxWidth - 30) / 4;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4,
                            (index) => _buildOtpBox(index, boxWidth, context)),
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: GestureDetector(
                      onTap: signInProvider.start == 0
                          ? () {
                              FocusScope.of(context).unfocus();
                              signInProvider.resetTimer();
                            }
                          : null,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: signInProvider.start == 0
                                  ? 'Resend code'
                                  : 'Resend code in ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: signInProvider.start == 0
                                    ? MyColors.GreyWithDarkOpacity
                                    : MyColors.black87,
                              ),
                            ),
                            if (signInProvider.start != 0)
                              TextSpan(
                                text: '${signInProvider.start} s',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black87,
                                ),
                              ),
                          ],
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
      ),
    );
  }
}
