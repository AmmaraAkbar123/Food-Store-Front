import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
              ? Center(child: Text(provider.errorMessage!))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: HtmlWidget(
                      provider.businessModel?.data.first.aboutUs ??
                          '<p>No information available.</p>',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
    );
  }
}
