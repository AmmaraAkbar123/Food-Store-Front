import 'package:flutter/material.dart';
import 'package:foodstorefront/models/business_model.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/authentication/sign_in_auth.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_social_button.dart';
import 'widgets/custom_phone_textfield.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomArrowBackButton(),
                Consumer<BusinessProvider>(
                  builder: (context, businessProvider, child) {
                    if (businessProvider.errorMessage != null) {
                      return Center(
                        child: Text(businessProvider.errorMessage!),
                      );
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
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset(
                                "assets/images/defaultimage.jpeg",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  'Unlock Your OneApp experience',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 40),
                CustomPhoneTextField(
                  phoneController: phoneController,
                  phoneFocusNode: _emailFocusNode,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    final phoneNumber = phoneController.text.trim();
                    print('Phone number entered: $phoneNumber');

                    if (phoneNumber.isNotEmpty) {
                      final signInProvider =
                          Provider.of<SignInProvider>(context, listen: false);
                      signInProvider.sendOtp(phoneNumber, context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter a phone number')),
                      );
                    }
                  },
                  clrtext: MyColors.white,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Or',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 40),
                CustomSocialButton(
                  text: "Continue with Google",
                  imagePath: "assets/icons/icons8-google-24.png",
                  onPressed: () {
                    // Implement Google Sign-In
                  },
                ),
                const SizedBox(height: 20),
                CustomSocialButton(
                  text: "Continue with Facebook",
                  imagePath: "assets/icons/icons8-facebook-24.png",
                  onPressed: () {
                    // Implement Facebook Sign-In
                  },
                ),
                const SizedBox(height: 20),
                CustomSocialButton(
                  text: "Continue with Apple",
                  imagePath: "assets/icons/apple-icon.png",
                  onPressed: () {
                    // Implement Apple Sign-In
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
