import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding and decoding JSON
import 'package:foodstorefront/models/product_model.dart';

class LocalStorageService {
String _getCartKeyForUser(int userId) => 'cart_items_$userId';
  static const String _deliveryOptionKey = 'delivery_option';

 Future<void> saveCartItems(int userId, Map<ProductModel, int> cartItems) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final cartItemsJson = cartItems.map((product, quantity) =>
      MapEntry(jsonEncode(product.toJson()), quantity));
  await prefs.setString(_getCartKeyForUser(userId), jsonEncode(cartItemsJson));
}


  Future<Map<ProductModel, int>> loadCartItems(int userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final cartItemsString = prefs.getString(_getCartKeyForUser(userId));
  if (cartItemsString == null) return {};

  final Map<String, dynamic> cartItemsJson = jsonDecode(cartItemsString);
  final Map<ProductModel, int> cartItems =
      cartItemsJson.map((productJson, quantity) {
    final product = ProductModel.fromJson(jsonDecode(productJson));
    return MapEntry(product, quantity);
  });

  return cartItems;
}

  Future<void> saveDeliveryOption(String deliveryOption) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deliveryOptionKey, deliveryOption);
  }

  Future<String?> loadDeliveryOption() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deliveryOptionKey);
  }
}
