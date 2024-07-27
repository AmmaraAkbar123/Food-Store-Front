import 'dart:convert';
import 'package:foodstorefront/config.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/services/authentication_service.dart';
import 'package:http/http.dart' as http;

class ProductApiService {
  final String _baseUrl =
      'https://dev.api.myignite.online/api/store-front/products';

  Future<List<ProductModel>> fetchProducts() async {
    final token = await AuthenticationService.getToken();
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel?> fetchProductByName(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl?name=$name'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return ProductModel.fromJson(
            data[0]); // Fetch the first product from the list
      } else {
        return null; // No product found with the given name
      }
    } else {
      throw Exception('Failed to load product');
    }
  }
}
