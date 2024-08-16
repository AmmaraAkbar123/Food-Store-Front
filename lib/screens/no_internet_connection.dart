import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetScreen({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagesStrings.appLogo,
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              "No Internet Connection",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please check your internet settings and try again.",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
