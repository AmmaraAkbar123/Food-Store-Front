import 'package:flutter/material.dart';
import 'package:foodstorefront/my_app.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/radio_provider.dart';
import 'package:provider/provider.dart';
import 'provider/store_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
    // debugPaintSizeEnabled = true;
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider(),),
        ChangeNotifierProvider(create: (_) => ProductProvider(),),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryInfoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

