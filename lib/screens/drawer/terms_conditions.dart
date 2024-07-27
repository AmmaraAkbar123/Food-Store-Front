import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessProvider>(context);

    return Scaffold(
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
              ? Center(child: Text(provider.errorMessage!))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImagesStrings
                                .burgerimage), // Path to your banner image
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Terms and Conditions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Welcome to Our Terms and Conditions',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        provider.businessModel?.data.first.termsAndCondition ??
                            'No terms and conditions available.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
    );
  }
}
