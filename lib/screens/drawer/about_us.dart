import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
              ? Center(child: Text(provider.errorMessage!))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    provider.businessModel?.data.first.aboutUs ??
                        'No information available.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
    );
  }
}
