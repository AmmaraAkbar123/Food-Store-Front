import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:foodstorefront/models/product_model.dart';

class LocalStorageService {
  String _getCartKeyForUser(int userId) => 'cart_items_$userId';
  static const String _deliveryOptionKey = 'delivery_option';

  // Save cart items with ProductModel serialized to JSON
Future<void> saveCartItems(int userId, Map<ProductModel, int> cartItems) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final Map<String, dynamic> cartItemsJson = cartItems.map((product, quantity) {
    final productJson = jsonEncode(product.toJson()); 
    return MapEntry(product.id.toString(), { 'product': productJson, 'quantity': quantity });
  });

  await prefs.setString(_getCartKeyForUser(userId), jsonEncode(cartItemsJson));
}

  // Load cart items and deserialize them back to ProductModel
 Future<Map<ProductModel, int>> loadCartItems(int userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final cartString = prefs.getString(_getCartKeyForUser(userId));
  
  if (cartString != null) {
    final Map<String, dynamic> decodedCart = jsonDecode(cartString);

    final Map<ProductModel, int> cartItems = {};

    for (var entry in decodedCart.entries) {
      final productData = entry.value as Map<String, dynamic>;

      final productJson = productData['product'] as String;
      final quantity = productData['quantity'] as int;

      final product = ProductModel.fromJson(jsonDecode(productJson));
      cartItems[product] = quantity;
    }

    return cartItems;
  }

  return {}; 
}

  // Save selected delivery option
  Future<void> saveDeliveryOption(String deliveryOption) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deliveryOptionKey, deliveryOption);
  }

  // Load selected delivery option
  Future<String?> loadDeliveryOption() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deliveryOptionKey);
  }
}
