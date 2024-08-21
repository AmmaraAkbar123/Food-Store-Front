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

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }

  int getQuantity(ProductModel product) {
    if (_currentUserId != null && _userCarts[_currentUserId!] != null) {
      return _userCarts[_currentUserId]![product] ?? 0;
    } else {
      return 0;
    }
  }

  int get totalCartQuantity {
    if (_currentUserId != null && _userCarts[_currentUserId!] != null) {
      // Sum all the quantities of products in the cart
      return _userCarts[_currentUserId!]!
          .values
          .fold(0, (sum, quantity) => sum + quantity);
    }
    return 0;
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

  void setOptionSelected(bool isSelected) {
    _isOptionSelected = isSelected;
    notifyListeners();
  }

  

  // Method to add or update product quantity in the cart
  void addProduct(ProductModel product, {int quantityToAdd = 1}) {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!] ??= {}; // Initialize cart if not present
      final cart = _userCarts[_currentUserId!]!;

      // Check if product already exists in the cart
      if (cart.containsKey(product)) {
        cart[product] = cart[product]! + quantityToAdd; // Update quantity
      } else {
        cart[product] =
            quantityToAdd; // Add new product with specified quantity
      }

      _addedProducts.add(product); // Track added product
      saveCartToLocalStorage(); // Save cart state to local storage
      notifyListeners(); // Notify listeners about cart update
    }
  }
  void removeProduct(ProductModel product) {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!] ??= {};
      final cart = _userCarts[_currentUserId!]!;

      if (cart.containsKey(product)) {
        cart.remove(product); // Remove product completely from cart
        _addedProducts.remove(product); // Remove from added products list
        saveCartToLocalStorage();
        notifyListeners();
      }
    }
  }

  
  void incrementQuantity(ProductModel product) {
  if (_currentUserId != null && cartItems.containsKey(product)) {
    final currentQuantity = cartItems[product]!;
    _userCarts[_currentUserId!]![product] = currentQuantity + 1;

    saveCartToLocalStorage(); // Save cart state to local storage
    notifyListeners(); // Notify listeners to update UI
  }
}


  void decrementQuantity(ProductModel product) {
  if (_currentUserId != null && cartItems.containsKey(product)) {
    final currentQuantity = cartItems[product]!;

    // Decrement quantity if greater than 1
    if (currentQuantity > 1) {
      _userCarts[_currentUserId!]![product] = currentQuantity - 1;
    } else if (currentQuantity == 1) {
      // If quantity is 1 and we're decrementing, remove the product
      _userCarts[_currentUserId!]!.remove(product);
      _addedProducts.remove(product);
    }

    saveCartToLocalStorage(); // Save cart state to local storage
    notifyListeners(); // Notify listeners to update UI
  }
}

  // Method to handle adding products from the UI
  void addToCart(BuildContext context, ProductModel product) {
    if (_currentUserId != null) {
      // Add the product with the existing quantity
      addProduct(product, quantityToAdd: 1);

      // Show confirmation message
      _showSnackBar(context, 'Product added to cart!');
    } else {
      _showSnackBar(context, 'Error: User ID is null.');
    }
  }

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
    if (_currentUserId != null) {
      if (newQuantity > 0) {
        _userCarts[_currentUserId!]![product] = newQuantity; // Update quantity
      } else {
        removeProduct(product); // Remove product if quantity is 0
      }
      saveCartToLocalStorage();
      notifyListeners();
    }
  }

  Future<void> saveCartToLocalStorage() async {
    if (_currentUserId != null) {
      await _localStorageService.saveCartItems(
        _currentUserId!,
        _userCarts[_currentUserId!]!,
      );
      await _localStorageService.saveDeliveryOption(_selectedDeliveryOption);
    }
  }

  Future<void> loadCartAndDeliveryOptions() async {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!] =
          await _localStorageService.loadCartItems(_currentUserId!);
      _selectedDeliveryOption =
          await _localStorageService.loadDeliveryOption() ?? "Delivery";
      notifyListeners();
    }
  }

  void setDeliveryOption(String option) {
    _selectedDeliveryOption = option;
    saveCartToLocalStorage();
    notifyListeners();
  }

  void clearCart() {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!]?.clear();
      saveCartToLocalStorage();
      notifyListeners();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
