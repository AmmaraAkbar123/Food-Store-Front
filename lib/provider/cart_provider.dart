import 'package:flutter/material.dart';
import 'package:foodstorefront/models/cart_model.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/services/local_storage_service.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartDetail> _cartItems = {};
  String _selectedDeliveryOption = 'Delivery';
  late CartModel cart;

  Map<int, CartDetail> get cartItems => _cartItems;
  String get selectedDeliveryOption => _selectedDeliveryOption;

  CartProvider() {
    loadCartAndDeliveryOptions();
  }

  // Method to add or update product quantity in the cart
  void addProduct(ProductModel product, {double quantityToAdd = 1.0}) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity += quantityToAdd;
    } else {
      _cartItems[product.id] = CartDetail(
        id: _cartItems.length + 1,
        cartId: cart.id,
        productId: product.id,
        variationId: '', // Adjust if needed
        quantity: quantityToAdd,
        unitPrice: product.price,
        totalPrice: product.price! * quantityToAdd,
      );
    }
    _updateCartTotals();
    notifyListeners();
  }

  // Method to remove product or decrease quantity
  void removeProduct(ProductModel product) {
    if (_cartItems.containsKey(product.id)) {
      if (_cartItems[product.id]!.quantity > 1) {
        _cartItems[product.id]!.quantity--;
      } else {
        _cartItems.remove(product.id);
      }
      _updateCartTotals();
      notifyListeners();
    }
  }

  void updateDeliveryOption(String option) {
    _selectedDeliveryOption = option;
    _updateCartTotals();
    _saveCartAndDeliveryOptions();
    notifyListeners();
  }

  void _updateCartTotals() {
    double subtotal = 0.0;
    _cartItems.forEach((key, cartDetail) {
      subtotal += cartDetail.calculateTotalPrice();
    });

    cart.subtotal = subtotal;
    cart.tax = subtotal * 0.18;
    cart.deliveryCharges = _selectedDeliveryOption == 'Delivery' ? 150.0 : 0.0;
    cart.discount = 0.0;
    cart.calculateTotal();
  }

  Future<void> _saveCartAndDeliveryOptions() async {
    final LocalStorageService localStorageService = LocalStorageService();
    await localStorageService.saveDeliveryOption(_selectedDeliveryOption);
  }

  Future<void> loadCartAndDeliveryOptions() async {
    final LocalStorageService localStorageService = LocalStorageService();
    _selectedDeliveryOption =
        await localStorageService.loadDeliveryOption() ?? 'Delivery';
    notifyListeners();
  }
}
