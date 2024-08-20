import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/user_provider.dart';
import 'package:foodstorefront/services/local_storage_service.dart';

class CartProvider with ChangeNotifier {
  ProductModel? _selectedProduct;
  bool _isOptionSelected = false;
  Set<int> selectedIndices = {}; // For selected indices
  final Map<String, String> _selectedOptions = {}; // For selected options
  final Map<int, Map<ProductModel, int>> _userCarts = {}; // User-specific carts
  int? _currentUserId; // Track the current user ID
  final UserProvider _userProvider;

  // New fields for cart management
  final Set<ProductModel> _addedProducts = {}; // Track added products

  ProductModel? get selectedProduct => _selectedProduct;
  bool get isOptionSelected => _isOptionSelected;
  Map<String, String> get selectedOptions => _selectedOptions;
  Map<ProductModel, int> get cartItems =>
      _userCarts[_currentUserId] ?? {}; // Cart items for the current user
  Set<ProductModel> get addedProducts => _addedProducts;

  final LocalStorageService _localStorageService = LocalStorageService();
  String _selectedDeliveryOption = "Delivery";

  // Getter for the delivery option
  String get selectedDeliveryOption => _selectedDeliveryOption;

  // Initialize with user provider
  CartProvider(this._userProvider) {
    _currentUserId = _userProvider.userId;
    loadCartAndDeliveryOptions();
  }

  // Set the current user ID (should be called when a user logs in)
  void setUser(int userId) {
    _currentUserId = userId;
    loadCartAndDeliveryOptions();
  }


  void setOptionSelected(bool isSelected) {
    _isOptionSelected = isSelected;
    notifyListeners();
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

  // Method to add or update product quantity in the cart
  void addProduct(ProductModel product, {int quantityToAdd = 1}) {
    if (_currentUserId != null) {
      _userCarts[_currentUserId!] ??= {}; // Initialize cart if not present
      final cart = _userCarts[_currentUserId!]!;

      // Debugging: Print current cart state before addition
      print("Before adding product: $cart");

      // Check if product already exists in the cart
      if (cart.containsKey(product)) {
        cart[product] = cart[product]! + quantityToAdd; // Update quantity
      } else {
        cart[product] =
            quantityToAdd; // Add new product with specified quantity
      }

      // Debugging: Print updated cart state
      print("After adding product: $cart");

      _addedProducts.add(product); // Update list of added products
      saveCartToLocalStorage(); // Save cart state to local storage
      notifyListeners(); // Notify listeners about cart update
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

  // bool isProductAdded(ProductModel product) {
  //   return _addedProducts.contains(product);
  // }

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
