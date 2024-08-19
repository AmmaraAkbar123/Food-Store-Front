import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/services/secure_storage.dart';
import 'package:http/http.dart' as http;

class PlaceOrderProvider with ChangeNotifier {
  Future<void> createOrder(
    List<ProductModel> products,
    String orderType,
    String shippingCharges,
    String deliveredTo,
    double totalBeforeTax, // Add this parameter
    double taxAmount, // Add this parameter
  ) async {
    final url = Uri.parse(
        'https://api.myignite.online/connector/api/sell'); // Replace with your API endpoint

    // Convert product data to the format expected by the API
    final List<Map<String, dynamic>> productData = products.map((product) {
      final variation =
          product.variations.isNotEmpty ? product.variations.first : null;
      return {
        "product_id": product.id,
        "variation_id": variation?.id,
        "quantity": 1, // Adjust quantity as needed
        "unit_price": product.price,
        "tax_rate_id": null,
        "discount_amount": 0,
        "sell_price_inc_tax":
            variation?.sellPriceIncTax ?? product.price.toString(),
      };
    }).toList();

    final Map<String, dynamic> body = {
      "sells": [
        {
          "selling_price_group_id": "",
          "sale_note": "",
          "shipping_status": "pending",
          "status": "final",
          "shipping_address": "",
          "order_type": orderType, // Use dynamic order type
          "location_id": "288",
          "contact_id": "13495",
          "delivered_to": deliveredTo, // Use the deliveredTo parameter
          "shipping_charges": shippingCharges, // Use dynamic shipping charges
          "shipping_custom_field_4": "Sell shipping method",
          "discount_amount": "0.0000",
          "shipping_longitude": "45.079162",
          "shipping_latitude": "23.885942",
          "shipping_city": "Riyadh",
          "einvoicing_status": "yet_to_be_pushed",
          "payments": [
            {
              "amount": "215",
              "method": "cash",
              "card_type": null,
              "note": "Test notes"
            }
          ],
          "order_source": "storefront",
          "total_before_tax":
              totalBeforeTax, // Use the totalBeforeTax parameter
          "tax_amount": taxAmount, // Use the taxAmount parameter
          "products": productData,
          "custom_field_4": null,
          "payment_method": null
        }
      ]
    };

    try {
      // Log the request details
      print("Request URL: $url");
      print("Request Headers: ${json.encode({
            'Content-Type': 'application/json',
            'Authorization': 'Bearer <TOKEN>'
          })}");
      print("Request Body: ${json.encode(body)}");

      // Retrieve the authentication token
      final token = await AuthenticationService.getToken();
      print("Retrieved Token: $token");

      // Send the POST request to the API
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      // Log the response details
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Handle successful order creation
        final responseData = json.decode(response.body);
        print("Order created successfully: $responseData");
      } else {
        // Handle error response
        print(
            "Failed to create order: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      // Handle any exceptions
      print("Error creating order: $e");
    }
  }
}