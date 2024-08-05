import 'package:flutter/material.dart';
import 'package:foodstorefront/my_app.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/radio_provider.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/store_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  //debugPaintSizeEnabled = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(
            create: (_) => SignInProvider(sharedPreferences)),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryInfoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
