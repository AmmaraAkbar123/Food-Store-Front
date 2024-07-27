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
     // print('Retrieved token in CategoryProvider: $token');

      if (token == null) {
       // print('Token not found in CategoryProvider');
        throw Exception('Token not found in CategoryProvider');
      }

   //   print('Fetching categories with token: $token');

      final response = await http.get(
        Uri.parse('https://dev.api.myignite.online/api/store-front/categories'),
        headers: {'Authorization': 'Bearer $token'},
      );

      // print('Response status: ${response.statusCode}');
      // print('Response headers: ${response.headers}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        //  print('Decoded response: $decodedResponse');

        if (decodedResponse is Map<String, dynamic>) {
          categoryModel = CategoryModel.fromJson(decodedResponse);
          errorMessage = null;
        } else {
          errorMessage = 'Unexpected response format';
          print('Error: $errorMessage');
        }
      } else {
        errorMessage = 'Failed to load categories: ${response.statusCode}';
        print('Error: $errorMessage');
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
