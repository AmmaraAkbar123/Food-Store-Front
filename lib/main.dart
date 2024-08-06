import 'package:flutter/material.dart';
import 'package:foodstorefront/my_app.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/radio_provider.dart';
import 'package:foodstorefront/services/share_pref_service.dart';
import 'package:foodstorefront/services/sign_in_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/store_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final cruds = Cruds(sharedPreferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(create: (_) => cruds),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryInfoProvider()),
      ],
      child: MyApp(cruds: cruds),
    ),
  );
}
