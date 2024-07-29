import 'dart:convert';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/services/authentication_service.dart';
import 'package:http/http.dart' as http;

class ProductApiService {
  final String _baseUrl = 'https://dev.api.myignite.online/api/store-front/products';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final token = await AuthenticationService.getToken();
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = json.decode(response.body);
          return data.map((json) => ProductModel.fromJson(json)).toList();
        } catch (e) {
          throw Exception('Failed to parse response: ${e.toString()}');
        }
      } else {
        print('Error fetching products. Status code: ${response.statusCode}\nResponse body: ${response.body}');
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: ${e.toString()}');
    }
  }

  Future<ProductModel?> fetchProductByName(String name) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?name=$name'));

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = json.decode(response.body);
          if (data.isNotEmpty) {
            return ProductModel.fromJson(data[0]);
          } else {
            return null; // No product found with the given name
          }
        } catch (e) {
          throw Exception('Failed to parse response: ${e.toString()}');
        }
      } else {
        print('Error fetching product by name. Status code: ${response.statusCode}\nResponse body: ${response.body}');
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching product by name: ${e.toString()}');
    }
  }
}