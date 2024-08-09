import 'package:flutter/material.dart';
import 'package:foodstorefront/api_services/product/product_api_service.dart';
import 'package:foodstorefront/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  ProductModel? _selectedProduct;
  bool _isLoading = false;
  bool _isProductLoading = false;
  int _quantity = 1;
  bool _isOptionSelected = false;
  Set<int> selectedIndices = {}; // New field for selected indices
  final Map<String, String> _selectedOptions =
      {}; // New field for selected options
  String _specialInstructions = ''; // New field for special instructions

  // New fields for cart management
  final Map<ProductModel, int> _cartItems =
      {}; // Cart items and their quantities
  final Set<ProductModel> _addedProducts = {}; // Track added products

  List<ProductModel> get products => _products;
  ProductModel? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  bool get isProductLoading => _isProductLoading;
  int get quantity => _quantity;
  bool get isOptionSelected => _isOptionSelected;
  Map<String, String> get selectedOptions => _selectedOptions;
  String get specialInstructions => _specialInstructions;
  Map<ProductModel, int> get cartItems => _cartItems;
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

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) _quantity--;
    notifyListeners();
  }

  void setOptionSelected(bool isSelected) {
    _isOptionSelected = isSelected;
    notifyListeners();
  }

  // Add or remove items in the cart
  void addToCart(ProductModel product) {
    if (!_addedProducts.contains(product)) {
      _cartItems[product] = (_cartItems[product] ?? 0) + 1;
      _addedProducts.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(ProductModel product) {
    if (_addedProducts.contains(product)) {
      if (_cartItems[product] == 1) {
        _cartItems.remove(product);
        _addedProducts.remove(product);
      } else {
        _cartItems[product] = (_cartItems[product] ?? 0) - 1;
      }
      notifyListeners();
    }
  }

  bool isProductAdded(ProductModel product) {
    return _addedProducts.contains(product);
  }

  void selectOption(String productName, String option) {
    _selectedOptions[productName] = option;
    notifyListeners();
  }

  void updateSpecialInstructions(String instructions) {
    _specialInstructions = instructions;
    notifyListeners();
  }

  // New method for toggling selection
  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }
}
