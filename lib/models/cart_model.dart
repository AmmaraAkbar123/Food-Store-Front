class Cartt {
  final int id;
  double subtotal;
  double tax;
  double deliveryCharges;
  double discount;
  double total;

  Cartt({
    required this.id,
    required this.subtotal,
    required this.tax,
    required this.deliveryCharges,
    required this.discount,
    required this.total,
  });

  void calculateTotal() {
    total = (subtotal + tax + deliveryCharges) - discount;
  }

  factory Cartt.fromJson(Map<String, dynamic> json) {
    return Cartt(
      id: json['id'],
      subtotal: json['subtotal'],
      tax: json['tax'],
      deliveryCharges: json['deliveryCharges'],
      discount: json['discount'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
  final int cartId; // Unique identifier for the cart item
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

  double calculateTotalPrice() {
    return quantity * unitPrice!;
  }

  factory CartDetail.fromJson(Map<String, dynamic> json) {
    return CartDetail(
      id: json['id'],
      cartId: json['cartId'],
      productId: json['productId'],
      variationId: json['variationId'] ?? "",
      quantity: json['quantity'],
      unitPrice: json['unitPrice'] ?? "",
      totalPrice: json['totalPrice'] ?? "",
    );
  }

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
