import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/splash/splash_screen.dart';
import 'package:foodstorefront/services/share_pref_service.dart';

class MyApp extends StatelessWidget {
  final Cruds cruds;

  const MyApp({super.key, required this.cruds});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodStore Front',
      // theme: ThemeData(textTheme: MyTextTheme.lightTextTheme),
      home: SplashScreen(cruds: cruds), // Pass cruds to SplashScreen
    );
  }
}
