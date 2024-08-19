import 'dart:convert';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/services/secure_storage.dart';
import 'package:http/http.dart' as http;

Future<void> createOrder(List<ProductModel> products, String orderType,
    String shippingCharges) async {
  final url = Uri.parse(
      'https://api.myignite.online/connector/api/sell'); // Replace with your API endpoint

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
        "delivered_to": "Muhammad Mehboob",
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
        "total_before_tax": "100.0000",
        "products": productData,
        "custom_field_4": null,
        "payment_method": null
      }
    ]
  };

  try {
    final token = await AuthenticationService.getToken();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // Handle successful order creation
      final responseData = json.decode(response.body);
      print("Order created successfully: $responseData");
    } else {
      // Handle error response
      print("Failed to create order: ${response.body}");
    }
  } catch (e) {
    print("Error creating order: $e");
  }
}
