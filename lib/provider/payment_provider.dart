import 'package:flutter/material.dart';
import 'package:foodstorefront/models/payment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentProvider with ChangeNotifier {
  List<PaymentDatum> _paymentMethods = [];

  List<PaymentDatum> get paymentMethods => _paymentMethods;

  Future<void> fetchPaymentMethods() async {
    const url = 'https://pay.myignite.online/api/payment_gateway/SAR';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'merchant-uuid': "D91A1B735A914",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _paymentMethods = Featured.fromMap(data).data;
      notifyListeners();
    } else {
      throw Exception('Failed to load payment methods');
    }
  }
}
