import 'package:flutter/material.dart';
import 'package:foodstorefront/api_services/product/product_api_service.dart';
import 'package:foodstorefront/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  ProductModel? _selectedProduct;
  bool _isLoading = false;
  bool _isProductLoading = false;

  List<ProductModel> get products => _products;
  ProductModel? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  bool get isProductLoading => _isProductLoading;

  final ProductApiService _productApiService = ProductApiService();

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productApiService.fetchProducts();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductByName(String name) async {
    _isProductLoading = true;
    notifyListeners();

    try {
      _selectedProduct = await _productApiService.fetchProductByName(name);
      print("_selectedProduct in provider::::$_selectedProduct");
    } catch (e) {
      print('Error fetching product: $e');
    } finally {
      _isProductLoading = false;
      notifyListeners();
    }
  }
}
