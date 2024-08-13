import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/authentication/sign_in_auth.dart';
import 'package:foodstorefront/utils/colors.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({required this.phoneNumber, super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SignInProvider>(context, listen: false).startTimer();
    });
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  Future<void> _verifyOtp(String otp, BuildContext context) async {
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
                  customArrowBackButton(),
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
                  const SizedBox(height: 30),
                  PinCodeTextField(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    showCursor: true,
                    cursorColor: MyColors.black,
                    cursorHeight: 50,
                    length: 4,
                    textStyle:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight:
                          100, // Increased field height as you required
                      fieldWidth: 75, // Increased field width as you required
                      activeFillColor: Colors.white,
                      activeColor: MyColors.black,
                      inactiveFillColor: Colors.white,
                      inactiveColor: MyColors.lightGrey,
                      selectedFillColor: Colors.white,
                      selectedColor: MyColors.primary,
                    ),
                    keyboardType: TextInputType.number,
                    errorAnimationController: errorController,
                    appContext: context,
                    autoFocus: true,
                    onChanged: (value) {
                      signInProvider.updateOtp(0, value);
                    },
                    onCompleted: (value) {
                      _verifyOtp(value, context);
                    },
                  ),
                  const SizedBox(height: 16),
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
