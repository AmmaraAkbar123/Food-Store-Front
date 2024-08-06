import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';

class SuccessfulCreatedScreen extends StatelessWidget {
  const SuccessfulCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customArrowBackButton(),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account \nCreated!",
                  style: TextStyle(
                    height: 1,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your account has been successfully created.\nLet's continue to setup your business",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 80),
                Image(
                  image: AssetImage(
                      'assets/images/pandasplash.png'), // Replace with your image asset
                  width: double.infinity, // Adjust the width if necessary
                  height: 200, // Adjust the height if necessary
                  fit: BoxFit.cover, // Adjust the fit if necessary
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
