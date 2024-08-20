import 'package:foodstorefront/models/cart_model.dart';

// Calculate total price of all cart details
double calculateTotalBeforeTax(List<CartDetail> cartDetails) {
  double itemsPrice = cartDetails.fold(0, (sum, detail) {
    return sum + (detail.unitPrice ?? 0.0) * detail.quantity;
  });
  return itemsPrice;
}

// Calculate tax amount based on items price and tax rate
double calculateTaxAmount(double itemsPrice, double taxRate) {
  return itemsPrice * taxRate;
}

// Calculate price summary for the cart
Map<String, double> calculatePriceSummary(
    List<CartDetail> cartDetails, String deliveryOption,
    {double taxRate = 0.18, double deliveryCharge = 50.0}) {
  double itemsPrice = calculateTotalBeforeTax(cartDetails);
  double tax = calculateTaxAmount(itemsPrice, taxRate);
  double subTotal = itemsPrice + tax;
  double totalDeliveryCharge = deliveryOption == "Delivery" ? deliveryCharge : 0.0;
  double total = subTotal + totalDeliveryCharge;

  return {
    'itemsPrice': itemsPrice,
    'tax': tax,
    'subTotal': subTotal,
    'deliveryCharge': totalDeliveryCharge,
    'total': total,
  };
}
