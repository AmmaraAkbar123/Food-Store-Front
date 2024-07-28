import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/splash/splash_screen.dart';
import 'package:foodstorefront/utils/text_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
