import 'package:flutter/material.dart';
import 'package:foodstorefront/api_services/api_service.dart';
import 'package:foodstorefront/models/business_model.dart';
import 'package:foodstorefront/services/secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BusinessProvider with ChangeNotifier {
  BusinessModel? _businessModel;
  bool _isLoading = true;
  String? _errorMessage;

  BusinessModel? get businessModel => _businessModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBusinessData() async {
    try {
      final response = await http
          .get(Uri.parse("${ApiService.proBusinessUrl}/business/grocery"));

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        //  print('Decoded JSON: $jsonResponse');

        _businessModel = BusinessModel.fromJson(jsonResponse);
        //  print('Parsed business model: ${_businessModel?.toJson()}');

        // Check if we have data and a token
        if (_businessModel?.data.isNotEmpty ?? false) {
          final token = _businessModel!.data.first.token;
          if (token.isNotEmpty) {
            await AuthenticationService.saveToken(token);
            print('Token saved: $token');
          } else {
            print('Token is null or empty');
          }
        }

        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = 'Failed to load business data. Please try again later.';
        print(_errorMessage);
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      // Check the type of exception and set a user-friendly error message
      if (e is http.ClientException) {
        _errorMessage = 'Network error. Please check your internet connection.';
      } else if (e is FormatException) {
        _errorMessage = 'Invalid data format. Please try again later.';
      } else {
        _errorMessage = 'An unexpected error occurred. Please try again later.';
      }
      print(_errorMessage);
      _isLoading = false;
      notifyListeners();
    }
  }
}
