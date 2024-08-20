// import 'package:flutter/material.dart';
// import 'package:foodstorefront/models/product_model.dart';
// import 'package:foodstorefront/models/cart_model.dart';
// import 'package:foodstorefront/services/local_storage_service.dart';

// class CartProvider with ChangeNotifier {
//   final Map<int, Map<ProductModel, int>> _userCarts = {}; // User-specific carts
//   int? _currentUserId; // Track the current user ID
//   final LocalStorageService _localStorageService = LocalStorageService();
//   String _selectedDeliveryOption = "Delivery";
//   List<CartModel> _cartModels = []; // List of cart models

//   // Getter for the delivery option
//   String get selectedDeliveryOption => _selectedDeliveryOption;

//   // Cart items for the current user
//   Map<ProductModel, int> get cartItems => _userCarts[_currentUserId] ?? {};

//   List<CartModel> get cartModels => _cartModels;

//   // Initialize with user provider
//   void setUser(int userId) {
//     _currentUserId = userId;
//     loadCartAndDeliveryOptions();
//   }

//   void setDeliveryOption(String option) {
//     _selectedDeliveryOption = option;
//     notifyListeners();
//   }

//   Future<void> loadCartAndDeliveryOptions() async {
//     // Load cart and delivery options logic here
//     // Simulate loading cart data
//     _cartModels = _userCarts[_currentUserId]!.entries.map((entry) {
//       final product = entry.key;
//       final quantity = entry.value;
//       return CartModel(
//         id: product.id,
//         product: product,
//         subtotal: product.price * quantity,
//         tax: (product.price * quantity) * 0.07,
//         deliveryCharges: _selectedDeliveryOption == "Delivery" ? 50.0 : 0.0,
//         discount: 0.0,
//         total: (product.price * quantity) * 1.07 +
//             (_selectedDeliveryOption == "Delivery" ? 50.0 : 0.0),
//       );
//     }).toList();
//     notifyListeners();
//   }

//   Future<void> addProduct(ProductModel product, {int quantityToAdd = 1}) async {
//     if (_currentUserId != null) {
//       _userCarts[_currentUserId!] ??= {};
//       final cart = _userCarts[_currentUserId!]!;
//       if (cart.containsKey(product)) {
//         cart[product] = cart[product]! + quantityToAdd;
//       } else {
//         cart[product] = quantityToAdd;
//       }
//       await saveCartToLocalStorage();
//       notifyListeners();
//     }
//   }


//   Future<void> removeProduct(ProductModel product) async {
//     if (_currentUserId != null) {
//       _userCarts[_currentUserId!] ??= {};
//       final cart = _userCarts[_currentUserId!]!;
//       if (cart.containsKey(product)) {
//         if (cart[product] == 1) {
//           cart.remove(product);
//         } else {
//           cart[product] = cart[product]! - 1;
//         }
//         await saveCartToLocalStorage();
//         notifyListeners();
//       }
//     }
//   }

//   Future<void> saveCartToLocalStorage() async {
//     if (_currentUserId != null) {
//       final cartItems = _userCarts[_currentUserId!] ?? {};
//       await _localStorageService.saveCartItems(_currentUserId!, cartItems);
//     }
//   }

//   double getTotalBeforeTax() {
//     double itemsPrice = cartItems.entries
//         .fold(0, (sum, item) => sum + (item.key.price) * item.value);
//     double taxRate = 0.18; // Assuming 18% tax rate
//     double taxAmount = itemsPrice * taxRate;
//     return itemsPrice + taxAmount;
//   }

//   double getTotal() {
//     double totalBeforeTax = getTotalBeforeTax();
//     double deliveryCharge = _selectedDeliveryOption == "Delivery" ? 50.0 : 0.0;
//     return totalBeforeTax + deliveryCharge;
//   }
// }
