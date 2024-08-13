import 'package:flutter/material.dart';
import 'package:foodstorefront/api_services/product_api_service.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/user_provider.dart';
import 'package:foodstorefront/services/local_storage_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  ProductModel? _selectedProduct;
  bool _isLoading = false;
  bool _isProductLoading = false;
  int _quantity = 1;
  bool _isOptionSelected = false;
  Set<int> selectedIndices = {}; // For selected indices
  final Map<String, String> _selectedOptions = {}; // For selected options
  String _specialInstructions = ''; // For special instructions
  final Map<int, Map<ProductModel, int>> _userCarts = {}; // User-specific carts
  int? _currentUserId; // Track the current user ID
  final UserProvider _userProvider;

  // New fields for cart management
  final Set<ProductModel> _addedProducts = {}; // Track added products

  List<ProductModel> get products => _products;
  ProductModel? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  bool get isProductLoading => _isProductLoading;
  int get quantity => _quantity;
  bool get isOptionSelected => _isOptionSelected;
  Map<String, String> get selectedOptions => _selectedOptions;
  String get specialInstructions => _specialInstructions;
  Map<ProductModel, int> get cartItems =>
      _userCarts[_currentUserId] ?? {}; // Cart items for the current user
  Set<ProductModel> get addedProducts => _addedProducts;

  final ProductApiService _productApiService = ProductApiService();
  final LocalStorageService _localStorageService = LocalStorageService();
  String _selectedDeliveryOption = "Delivery";

  // Getter for the delivery option
  String get selectedDeliveryOption => _selectedDeliveryOption;

  // Initialize with user provider
  ProductProvider(this._userProvider) {
    _currentUserId = _userProvider.userId;
    loadCartAndDeliveryOptions();
  }

  // Set the current user ID (should be called when a user logs in)
  void setUser(int userId) {
    _currentUserId = userId;
    loadCartAndDeliveryOptions();
  }

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

  // Method to add a product to the cart
  void addToCart(BuildContext context, ProductModel product) {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!] ??= {};

      if (_userCarts[_currentUserId!]!.containsKey(product)) {
        _userCarts[_currentUserId!]![product] =
            _userCarts[_currentUserId!]![product]! + 1;
      } else {
        _userCarts[_currentUserId!]![product] =
            _quantity; // Start with the initial quantity
      }

      _addedProducts.add(product);
      saveCartToLocalStorage();
      _showSnackBar(context, 'Product added to cart!');
      notifyListeners();
    } else {
      _showSnackBar(context, 'Error: User ID is null.');
    }
  }

  // Method to remove a product from the cart
  void removeFromCart(BuildContext context, ProductModel product) {
    if (_currentUserId != null && _userCarts[_currentUserId!] != null) {
      final cart = _userCarts[_currentUserId!]!;
      if (cart.containsKey(product)) {
        if (cart[product] == 1) {
          cart.remove(product);
          _addedProducts.remove(product);
        } else {
          cart[product] = (cart[product] ?? 0) - 1;
        }
        saveCartToLocalStorage();
        _showSnackBar(context, 'Product removed from cart!');
        notifyListeners();
      }
    } else {
      _showSnackBar(context, 'Error: User ID is null.');
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

  void updateCart(ProductModel product, int newQuantity) {
    if (newQuantity > 0) {
      _userCarts[_currentUserId!]![product] = newQuantity;
    } else {
      _userCarts[_currentUserId!]!.remove(product);
      _addedProducts.remove(product);
    }
    saveCartToLocalStorage();
    notifyListeners();
  }

  // Adjust local storage methods to use the user ID
  Future<void> saveCartToLocalStorage() async {
    if (_currentUserId != null) {
      await _localStorageService.saveCartItems(
        _currentUserId!,
        _userCarts[_currentUserId!]!,
      );
      await _localStorageService.saveDeliveryOption(_selectedDeliveryOption);
    }
  }

  // Method to load cart items from local storage
  Future<void> loadCartAndDeliveryOptions() async {
    if (_currentUserId != null) {
      // Load the cart items directly from SharedPreferences
      final loadedCartItems =
          await _localStorageService.loadCartItems(_currentUserId!);
      final loadedDeliveryOption =
          await _localStorageService.loadDeliveryOption();

      // Replace the current cart with the loaded items
      _userCarts[_currentUserId!] = loadedCartItems;

      if (loadedDeliveryOption != null) {
        _selectedDeliveryOption = loadedDeliveryOption;
      }
      notifyListeners();
    }
  }

  void addProduct(ProductModel product) {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!] ??= {};
      final cart = _userCarts[_currentUserId!]!;

      if (cart.containsKey(product)) {
        cart[product] = cart[product]! + 1;
      } else {
        cart[product] = 1;
      }
      saveCartToLocalStorage();
      notifyListeners();
    }
  }

  void removeProduct(ProductModel product) {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!] ??= {};
      final cart = _userCarts[_currentUserId!]!;

      if (cart.containsKey(product)) {
        if (cart[product] == 1) {
          cart.remove(product);
        } else {
          cart[product] = cart[product]! - 1;
        }
        saveCartToLocalStorage();
        notifyListeners();
      }
    }
  }

  // Toggle selection for a product option
  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }

  // Update delivery option
  void updateDeliveryOption(String deliveryOption) {
    _selectedDeliveryOption = deliveryOption;
    saveCartToLocalStorage();
    notifyListeners();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
