import 'package:flutter/material.dart';
import 'package:foodstorefront/my_app.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/provider/cart_provider.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/provider/country_provider.dart';
import 'package:foodstorefront/provider/payment_provider.dart';
import 'package:foodstorefront/provider/place_order_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/radio_provider.dart';
import 'package:foodstorefront/provider/user_provider.dart';
import 'package:foodstorefront/authentication/sign_in_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/store_provider.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    bool isKeyEventError =
        details.exceptionAsString().contains('_pressedKeys.containsKey');
    if (!isKeyEventError) {
      FlutterError.presentError(details);
    }
  };

  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final userProvider = UserProvider(sharedPreferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(create: (_) => userProvider),
        ChangeNotifierProvider(create: (_) => CountryCodeProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        //  ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProxyProvider<UserProvider, ProductProvider>(
          create: (context) => ProductProvider(userProvider),
          update: (context, userProvider, productProvider) =>
              ProductProvider(userProvider),
        ),
        ChangeNotifierProvider(create: (_) => PlaceOrderProvider()),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryInfoProvider()),
      ],
      child: MyApp(userProvider: userProvider),
    ),
  );
}
