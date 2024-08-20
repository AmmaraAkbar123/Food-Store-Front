import 'package:foodstorefront/models/product_model.dart';

class CartModel {
  final int id;
  final ProductModel product;
  double subtotal;
  double tax;
  double deliveryCharges;
  double discount;
  double total;

  CartModel({
    required this.id,
    required this.product,
    required this.subtotal,
    required this.tax,
    required this.deliveryCharges,
    required this.discount,
    required this.total,
  });

  // Method to calculate the total
  void calculateTotal() {
    total = (subtotal + tax + deliveryCharges) - discount;
  }

  // Factory constructor to create an instance from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      subtotal: json['subtotal'],
      tax: json['tax'],
      deliveryCharges: json['deliveryCharges'],
      discount: json['discount'],
      total: json['total'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'subtotal': subtotal,
      'tax': tax,
      'deliveryCharges': deliveryCharges,
      'discount': discount,
      'total': total,
    };
  }
}

class CartDetail {
  final int id;
  final int cartId; // Unique identifier for the cart
  final int productId;
  String? variationId; // Ensure this field is present in ProductModel
  double quantity;
  double? unitPrice;
  double? totalPrice;

  CartDetail({
    required this.id,
    required this.cartId,
    required this.productId,
    this.variationId,
    this.quantity = 1.0,
    this.unitPrice,
    this.totalPrice,
  });

  // Method to calculate the total price for this cart detail
  double calculateTotalPrice() {
    return quantity * (unitPrice ?? 0.0);
  }

  // Factory constructor to create an instance from JSON
  factory CartDetail.fromJson(Map<String, dynamic> json) {
    return CartDetail(
      id: json['id'],
      cartId: json['cartId'],
      productId: json['productId'],
      variationId: json['variationId'],
      quantity: json['quantity'].toDouble(),
      unitPrice: json['unitPrice']?.toDouble(),
      totalPrice: json['totalPrice']?.toDouble(),
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cartId': cartId,
      'productId': productId,
      'variationId': variationId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': calculateTotalPrice(),
    };
  }
}
