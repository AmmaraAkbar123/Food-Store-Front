import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/user_provider.dart';
import 'package:foodstorefront/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  final UserProvider userProvider;

  const MyApp({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodStore Front',
      // theme: ThemeData(textTheme: MyTextTheme.lightTextTheme),
      home: SplashScreen(userProvider: userProvider), // Pass cruds to SplashScreen
    );
  }
}
