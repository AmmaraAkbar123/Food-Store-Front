import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch business data when the widget is built
    final provider = Provider.of<BusinessProvider>(context);

    // Use a FutureBuilder to handle the async operation
    if (provider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Terms and Conditions')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Terms and Conditions')),
        body: Center(child: Text(provider.errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: HtmlWidget(
            provider.businessModel?.data.first.termsAndCondition ??
                '<p>No terms and conditions available.</p>',
            textStyle: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
