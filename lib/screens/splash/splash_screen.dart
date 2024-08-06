import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/location/location_access_screen.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:foodstorefront/services/share_pref_service.dart';
import 'package:provider/provider.dart';

import '../../provider/business_provider.dart';
import '../login and signup/login/login_screen.dart';
import '../store/store_screen.dart';

class SplashScreen extends StatefulWidget {
  final Cruds cruds; // Add Cruds instance

  const SplashScreen({Key? key, required this.cruds}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
    fetchData();
  }

  Future<void> fetchData() async {
    final businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);

    await Future.wait([
      businessProvider.fetchBusinessData(),
    ]);
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});

    if (widget.cruds.isLoggedIn()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StoreScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LocationAccessScreen()),
      );
    }
  }

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
              height: 90,
              width: 90,
            ),
            const Text(
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
