import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Custom back button
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Implement your back navigation here
              },
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.primary, // Customize the color
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white, // Customize icon color
                  size: 13.0, // Customize icon size
                ),
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo image
                Image.asset(
                  ImagesStrings.appLogo, // Replace with your logo image path
                  height: 100, // Customize the height
                ),
                SizedBox(height: 20),
                // Text below the logo
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                // Email text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Custom login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement your login logic here
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Customize radius
                      ),
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0), // Customize button color
                    ),
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 20),
                // Or text
                Text('or'),
                SizedBox(height: 20),
                // Google login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement your Google login logic here
                    },
                    icon: Icon(Icons
                        .login), // Replace with Google icon if you have one
                    label: Text('Sign in with Google'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Customize radius
                      ),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0), // Customize button color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
