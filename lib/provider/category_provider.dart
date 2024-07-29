import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodstorefront/models/category_model.dart';
import 'package:foodstorefront/services/authentication_service.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  CategoryModel? categoryModel;
  bool isLoading = false;
  String? errorMessage;

  CategoryModel? get categories => categoryModel;

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      String? token = await AuthenticationService.getToken();
      if (token == null) {
        throw Exception('Token not found in CategoryProvider');
      }

      final response = await http.get(
        Uri.parse('https://dev.api.myignite.online/api/store-front/categories'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        try {
          final decodedResponse = json.decode(response.body);
          if (decodedResponse is Map<String, dynamic>) {
            categoryModel = CategoryModel.fromJson(decodedResponse);
            errorMessage = null;
          } else {
            errorMessage = 'Unexpected response format';
            print('Error: $errorMessage');
          }
        } catch (e) {
          errorMessage = 'Failed to parse response: ${e.toString()}';
          print('Error: $errorMessage');
        }
      } else {
        errorMessage = 'Failed to load categories: ${response.statusCode}';
        print('Error: $errorMessage\nResponse body: ${response.body}');
      }
    } catch (e) {
      errorMessage = 'Error: ${e.toString()}';
      print('Exception: ${e.toString()}');
    } finally {
      isLoading = false;
      Future.microtask(() => notifyListeners());
    }
  }
}
