import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/radio_provider.dart';
import 'package:foodstorefront/screens/splash_screen.dart';
import 'package:foodstorefront/utils/text_theme.dart';
import 'package:provider/provider.dart';

import 'provider/store_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // // Save token for testing
  // await SecureStorageHelper.saveToken(
  //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImIyNzY0ZDYxY2Q5ZGE3MDg2YmM4YWIzNDM0YjZlMTQyYmI0ZjhiYWVhMWZjYzIxNTRiNTRiOTk0MTFjNjdiMjkzMjQxMmRjMjQ0YzFkZjBjIn0.eyJhdWQiOiIzNSIsImp0aSI6ImIyNzY0ZDYxY2Q5ZGE3MDg2YmM4YWIzNDM0YjZlMTQyYmI0ZjhiYWVhMWZjYzIxNTRiNTRiOTk0MTFjNjdiMjkzMjQxMmRjMjQ0YzFkZjBjIiwiaWF0IjoxNzIxNzIyMDQ1LCJuYmYiOjE3MjE3MjIwNDUsImV4cCI6MTc1MzI1ODA0NSwic3ViIjoiODY5Iiwic2NvcGVzIjpbXX0.GV_WfqtmNxYHoiXj90EgKwYCsgfFsSxj-55CVNAst6ZP6J-FeXHtNvFrYVQ4G6JGpGpVCyTCJwID6hFm89D16nyUcYLZjSpdsjzKtEiIbsbgyBav-arhDNFwutdtng12VhMQsiBwvevlRp5y0BXR6ycPuIaPghG9_Avs60e7nTIYIwTGYmcMnPwj0QAqHvzDyDhcC9oO2l5Caw7wRgJHHknIvZsSiHhIrvA9BpgTdPQgYSRNjqrqDyTks_5Lf_PC0L_A3TEV7zUCOXJLMH7imdplZksicgU5j9BA880YaiKAVqPxSHiicCvG7al5IZNMdeUli0HXTf9nBLcfZTPtDv5F3taoBCAQzsssVapbr6dPc20WReEtVxo9zw_f8K-0CW6kvwKSloLuB1cLNt4q8Pal3wtFm5EMxd2nSwmg3FGwH_IpJM5949wFO0i-w4Pb42W-c1Fl_uhBCjIAiRXjIbDCfRybCUlJWwWzVUZiojG-HPWmGBlLhlxS-2kbkH-kH-E1Gz7fltWZhV-HOMoMTuQjOemRA9QYZh9MZ8mwSxj1Xnsd5YK1QvLxm-pUWP2CyMnbDrdpO0QgnZnNBtHiT7yPRqKE0cW29LEtNnSKIitzgW19geNmvjo8R2uPU-QgA-zuzDEyRFhVkSZP0dkzQDrocTeFOBjfLAQHKm5WJ9Q');

  // // Example usage
  // String? token = await SecureStorageHelper.getToken();
  // print('Retrieved token: $token');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryInfoProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodStore Front',
      theme: ThemeData(textTheme: MyTextTheme.lightTextTheme),
      home: const SplashScreen(),
    );
  }
}
