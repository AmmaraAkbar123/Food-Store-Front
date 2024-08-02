import 'package:flutter/material.dart';
import 'package:foodstorefront/models/business_model.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_social_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_textfield.dart';
import 'package:foodstorefront/screens/login%20and%20signup/otp/otp_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _buildLoginScreen(context),
      ),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    final signInViewProvider =
        Provider.of<SignInViewProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const customArrowBackButton(),
            Consumer<BusinessProvider>(
              builder: (context, businessProvider, child) {
                if (businessProvider.errorMessage != null) {
                  return Center(child: Text(businessProvider.errorMessage!));
                }

                if (businessProvider.businessModel == null) {
                  return const Center(child: Text('No data available'));
                }

                Datum business = businessProvider.businessModel!.data.first;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        business.logo ??
                            'https://t3.ftcdn.net/jpg/05/62/05/20/360_F_562052065_yk3KPuruq10oyfeu5jniLTS4I2ky3bYX.jpg',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 5),
            const Text(
              'Unlock Your App!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            CustomTextField(
              focusNode: _emailFocusNode,
              hintText: 'Enter your Phone number',
              prefixIcon: Icons.phone,
              controller: phoneController,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Continue',
              onPressed: () async {
                await signInViewProvider.verifyPhoneNumber(
                    context, phoneController.text);
                if (signInViewProvider.isOTPVerified) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPScreen(
                        // onBack: () => Navigator.pop(context),
                        phoneNumber: phoneController.text,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Or',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            CustomSocialButton(
              text: "Continue with Google",
              imagePath: "assets/icons/google-icon.png",
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            CustomSocialButton(
              text: "Continue with Facebook",
              imagePath: "assets/icons/fb-icon.png",
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            CustomSocialButton(
              text: "Continue with Apple",
              imagePath: "assets/icons/apple-icon.png",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
