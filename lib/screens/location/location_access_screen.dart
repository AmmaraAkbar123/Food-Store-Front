import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/login_screen.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:provider/provider.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  LocationAccessScreenState createState() => LocationAccessScreenState();
}

class LocationAccessScreenState extends State<LocationAccessScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    fetchData();
  }

  Future<void> fetchData() async {
    final businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);

    await Future.wait([
      businessProvider.fetchBusinessData(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    ImagesStrings.location,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Allow location access on the next screen for:',
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: MyColors.lightPrimary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.moped_outlined,
                            color: MyColors.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Finding the best restaurants\n and shops near you',
                            style: TextStyle(
                                height: 1.1,
                                fontSize: 17,
                                color: MyColors.textSecondary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: MyColors.lightPrimary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.storefront_outlined,
                            color: MyColors.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Faster and more accurate\n delivery',
                            style: TextStyle(
                                height: 1.1,
                                fontSize: 17,
                                color: MyColors.textSecondary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Added some space here
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 241, 241, 241)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                    child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void openLocationSettings() {
  //   openAppSettings().then((_) {
  //     print('Opened app settings');
  //   }).catchError((error) {
  //     print('Error opening app settings: $error');
  //   });
  // }

  //Start Show Message
  // void _showSnackBar(BuildContext context, String message,
  //     [Color color = Colors.red]) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           const Icon(Icons.error_outline, color: Colors.white),
  //           const SizedBox(width: 8),
  //           Expanded(
  //             child: Text(
  //               message,
  //               textAlign: TextAlign.left,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16.0,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       backgroundColor: color,
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       margin: const EdgeInsets.all(12),
  //       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }
  //End Show Message
}
