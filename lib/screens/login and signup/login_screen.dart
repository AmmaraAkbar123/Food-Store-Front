import 'package:flutter/material.dart';
import 'package:foodstorefront/models/business_model.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/screens/login%20and%20signup/widgets/custom_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/widgets/custom_social_button.dart';
import 'package:foodstorefront/screens/login%20and%20signup/widgets/custom_textfield.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart'; // Import your colors

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  const SizedBox(height: 40), // Top padding
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Implement your back navigation logic here
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.primary, // Customize the color
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white, // Customize icon color
                          size: 12.0, // Customize icon size
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Center top image
              Consumer<BusinessProvider>(
                builder: (context, businessProvider, child) {
                  if (businessProvider.errorMessage != null) {
                    return Center(
                        child: Text(businessProvider
                            .errorMessage!)); // Show error message
                  }

                  if (businessProvider.businessModel == null) {
                    return Center(
                        child: Text(
                            'No data available')); // Show a message if no data is available
                  }

                  Datum business = businessProvider.businessModel!.data
                      .first; // Assuming you want the first business

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          business.logo ??
                              'https://t3.ftcdn.net/jpg/05/62/05/20/360_F_562052065_yk3KPuruq10oyfeu5jniLTS4I2ky3bYX.jpg', // Handle null logo
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // const SizedBox(width: 15),
                      // Text(
                      //   business.name,
                      //   style: TextStyle(
                      //     color: MyColors.black,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 18,
                      //   ),
                      // ),
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
              // Email text field
              CustomTextField(
                hintText: 'Enter your Email address',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 40),
              // Custom button
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(context, '/navigationbar');
                },
              ),
              const SizedBox(height: 40),
              const Text(
                'Or',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              // Social buttons
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
      ),
    );
  }
}
