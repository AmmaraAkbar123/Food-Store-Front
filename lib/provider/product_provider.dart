import 'package:flutter/material.dart';
import 'package:foodstorefront/api_services/product_api_service.dart';
import 'package:foodstorefront/models/product_model.dart';
class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  ProductModel? _selectedProduct;
    bool _isOptionSelected = false;
  bool _isLoading = false;
    String _specialInstructions = ''; // For special instructions

  bool _isProductLoading = false;
  Set<int> selectedIndices = {}; // For selected indices
  final Map<String, String> _selectedOptions = {}; // For selected options
  final Map<int, Map<ProductModel, int>> _userCarts = {}; // User-specific carts
  int? _currentUserId; // Track the current user ID

  // New fields for cart management
  final Set<ProductModel> _addedProducts = {}; // Track added products

  List<ProductModel> get products => _products;
    String get specialInstructions => _specialInstructions;

  ProductModel? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
    bool get isOptionSelected => _isOptionSelected;
  bool get isProductLoading => _isProductLoading;
  Map<String, String> get selectedOptions => _selectedOptions;
  Map<ProductModel, int> get cartItems =>
      _userCarts[_currentUserId] ?? {}; // Cart items for the current user
  Set<ProductModel> get addedProducts => _addedProducts;

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
    } catch (e) {
      print('Error fetching product: $e');
    } finally {
      _isProductLoading = false;
      notifyListeners();
    }
  }
    void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }
   void selectOption(String productName, String option) {
    _selectedOptions[productName] = option;
    notifyListeners();
  }
  

  void setOptionSelected(bool isSelected) {
    _isOptionSelected = isSelected;
    notifyListeners();
  }
  void updateSpecialInstructions(String instructions) {
    _specialInstructions = instructions;
    notifyListeners();
  }

}
