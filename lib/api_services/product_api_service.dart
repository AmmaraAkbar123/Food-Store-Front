// ProductApiService class
import 'dart:convert';
import 'package:foodstorefront/api_services/api_service.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/services/secure_storage.dart';
import 'package:http/http.dart' as http;

class ProductApiService {
  final String _baseUrl = '${ApiService.proBaseUrl}/products';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final token = await AuthenticationService.getToken();
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = json.decode(response.body);
          return data.map((json) => ProductModel.fromJson(json)).toList();
        } catch (e) {
          throw Exception(
              'Failed to parse response in product: ${e.toString()}');
        }
      } else {
        print(
            'Error fetching products. Status code: ${response.statusCode}\nResponse body ProductApiService: ${response.body}');
        throw Exception('Failed to load products ProductApiService: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products : ${e.toString()}');
    }
  }
Future<ProductModel?> fetchProductByName(String name) async {
  try {
    final token = await AuthenticationService.getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl?name=$name'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          return null;
        }
        return ProductModel.fromJson(data[0]);
      } else {
        throw Exception('Unexpected content type: ${response.headers['content-type']}');
      }
    } else {
      print(
          'Error fetching product by name. Status code: ${response.statusCode}\nResponse body: ${response.body}');
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching product by name: ${e.toString()}');
  }
}

}
