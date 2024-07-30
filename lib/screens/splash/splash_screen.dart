import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/location/location_access_screen.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login_screen.dart';
import 'package:foodstorefront/utils/images_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF2B85),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImagesStrings.appLogo,
              height: 90,
              width: 90,
            ),
            Text(
              "FoodStoreFront",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
