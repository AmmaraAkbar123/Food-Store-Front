import 'package:flutter/material.dart';
import 'package:foodstorefront/models/cart_model.dart';
import 'package:foodstorefront/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartDetail> _cartItems = {};
  String _selectedDeliveryOption = 'Delivery';
  late Cartt cart;

  Map<int, CartDetail> get cartItems => _cartItems;
  String get selectedDeliveryOption => _selectedDeliveryOption;

  void addProduct(ProductModel product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity++;
    } else {
      _cartItems[product.id!] = CartDetail(
        id: _cartItems.length + 1,
        cartId: cart.id,
        productId: product.id,
        // variationId: '',
        // quantity: 1,
        unitPrice: product.price ?? 0.0,
        totalPrice: product.price ?? 0.0,
      );
    }
    _updateCartTotals();
    notifyListeners();
  }

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
}
