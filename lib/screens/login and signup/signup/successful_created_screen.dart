import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_arrow_back_button.dart';
import 'package:foodstorefront/screens/store/store_screen.dart';

class SuccessfulCreatedScreen extends StatelessWidget {
  const SuccessfulCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomArrowBackButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => StoreScreen()),
                      (route) => false,
                    )),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account \nCreated!",
                  style: TextStyle(
                    height: 1,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your account has been successfully created.\nLet's continue to setup your business",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 70),
                Image(
                  image: AssetImage(
                      'assets/images/imagwe.png'), // Replace with your image asset
                  width: double.infinity, // Adjust the width if necessary
                
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
