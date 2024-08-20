import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/cart_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/services/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PlaceOrderProvider with ChangeNotifier {
  Future<void> createOrder(
    BuildContext context, // Add context parameter
    List<ProductModel> products,
    String orderType,
    double shippingCharges, // Delivery charges parameter
    String deliveredTo,
  ) async {
    final url = Uri.parse(
        'https://api.myignite.online/connector/api/sell'); // Replace with your API endpoint

    // Calculate total before tax and tax amount dynamically
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    double itemsPrice = products.fold(
      0,
      (sum, item) => sum + (item.price * productProvider.getQuantity(item)),
    );

    double taxRate = 0.18; // Assuming 18% tax rate, adjust as needed
    double taxAmount = itemsPrice * taxRate;
    double totalBeforeTax = itemsPrice;

    // Include shippingCharges in the final total calculation
    double finalTotal = totalBeforeTax + taxAmount + shippingCharges;

    // Convert product data to the format expected by the API
    final List<Map<String, dynamic>> productData = products.map((product) {
      final variation =
          product.variations.isNotEmpty ? product.variations.first : null;
      return {
        "product_id": product.id,
        "variation_id": variation?.id,
        "quantity": productProvider.getQuantity(product), // Use actual quantity
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
          "shipping_address": "", // Add if needed
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
              "amount": finalTotal.toString(), // Update with final total
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
      print("Response Status Code PlaceOrderAPi: ${response.statusCode}");
      print("Response Body PlaceOrderAPi: ${response.body}");

      if (response.statusCode == 200) {
        // Handle successful order creation
        final responseData = json.decode(response.body);
        print("Order created successfully: $responseData");
        // Notify listeners or perform additional actions if needed
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
