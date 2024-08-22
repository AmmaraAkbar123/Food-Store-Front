import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/user_provider.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/separater.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';
import '../login and signup/login/widgets/custom_button.dart';
import 'place_order_screen.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .loadCartAndDeliveryOptions();
    });
  }

  double calculateTotalBeforeTax(Map<ProductModel, int> cartItems) {
    double itemsPrice = cartItems.entries
        .fold(0, (sum, item) => sum + (item.key.price) * item.value);
    return itemsPrice;
  }

  ///
  double calculateTaxAmount(double itemsPrice, double taxRate) {
    return itemsPrice * taxRate;
  }

  ////
  Map<String, double> calculatePriceSummary(
      Map<ProductModel, int> cartItems, String deliveryOption,
      {double taxRate = 0.18, double deliveryCharge = 50.0}) {
    double itemsPrice = calculateTotalBeforeTax(cartItems);
    double tax = calculateTaxAmount(itemsPrice, taxRate);
    double subTotal = itemsPrice + tax;
    double totalDeliveryCharge =
        deliveryOption == "Delivery" ? deliveryCharge : 0.0;
    double total = subTotal + totalDeliveryCharge;

    return {
      'itemsPrice': itemsPrice,
      'tax': tax,
      'subTotal': subTotal,
      'deliveryCharge': totalDeliveryCharge,
      'total': total,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: MyColors.white,
      appBar: buildAppBar(),
      body: buildBody(context),
      bottomNavigationBar:
          Provider.of<ProductProvider>(context).cartItems.isEmpty
              ? null
              : buildBottomBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: MyColors.white,
      elevation: 0,
      title: const Text("Cart"),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Widget buildBody(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.cartItems.isEmpty) {
          // If cart is empty, show a message and a button to go back to StoreScreen
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your cart is empty",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Back to Store",
                    style: TextStyle(fontSize: 16, color: MyColors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          // If cart is not empty, show the cart items and price summary
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildCartItemsList(productProvider),
                  const SizedBox(height: 50),
                  buildDeliveryOptions(productProvider),
                  const SizedBox(height: 15),
                  buildPriceSummary(productProvider.cartItems,
                      productProvider.selectedDeliveryOption),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildCartItemsList(ProductProvider productProvider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productProvider.cartItems.length,
      itemBuilder: (context, index) {
        final product = productProvider.cartItems.keys.elementAt(index);
        final quantity = productProvider.cartItems[product]!;
        return buildShoppingItemCard(context, product, quantity);
      },
    );
  }

  Widget buildShoppingItemCard(
      BuildContext context, ProductModel product, int quantity) {
    return Card(
      color: MyColors.white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // elevation: 2, // This applies elevation on all sides of the card
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductImage(product),
            const SizedBox(width: 16.0),
            Expanded(
              child: buildProductDetails(product),
            ),
            buildQuantityController(context, product, quantity),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage(ProductModel product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        product.image.thumbnail,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            "assets/images/defaultimage.jpeg",
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget buildProductDetails(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Code: ---',
          style: TextStyle(color: MyColors.greyText, fontSize: 15),
        ),
      ],
    );
  }

  Widget buildQuantityController(
      BuildContext context, ProductModel product, int quantity) {
    final provider = Provider.of<ProductProvider>(context);
    final double totalPrice = product.price * quantity;

    return Column(
      children: [
        Text(
          'Rs. ${totalPrice.toStringAsFixed(2)}', // Display total price with 2 decimal places
          style: const TextStyle(
              color: MyColors.primary, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                // Use decrementQuantity to reduce quantity by 1
                provider.decrementQuantity(product);
              },
            ),
            Text(
              '$quantity',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                provider.incrementQuantity(
                    product); // Use incrementQuantity instead of addProduct
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildDeliveryOptions(ProductProvider productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery Options",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildDeliveryOptionTile(
            "Delivery", "Delivery", productProvider.selectedDeliveryOption,
            (value) {
          productProvider.setDeliveryOption(value!);
        }),
        buildDeliveryOptionTile(
            "Pick Up", "Pickup", productProvider.selectedDeliveryOption,
            (value) {
          productProvider.setDeliveryOption(value!);
        }),
      ],
    );
  }

  Widget buildDeliveryOptionTile(String title, String value, String groupValue,
      Function(String?) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: MyColors.primary,
            visualDensity:
                VisualDensity.compact, // Optional: reduces the Radio's size
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, // Shrinks the tap area
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget buildPriceSummary(
      Map<ProductModel, int> cartItems, String deliveryOption) {
    final prices = calculatePriceSummary(cartItems, deliveryOption);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSummaryRow(
            "Items Price", "Rs. ${prices['itemsPrice']!.toStringAsFixed(2)}"),
        buildSummaryRow("Vat/Tax", "Rs. ${prices['tax']!.toStringAsFixed(2)}"),
        const SizedBox(height: 5),
        const MySeparator(),
        const SizedBox(height: 5),
        buildSummaryRow(
            "Subtotal", "Rs. ${prices['subTotal']!.toStringAsFixed(2)}",
            boldText: true),
        buildSummaryRow("Delivery Charge",
            "Rs. ${prices['deliveryCharge']!.toStringAsFixed(2)}"),
        const SizedBox(height: 5),
        const MySeparator(),
        const SizedBox(height: 5),
        buildSummaryRow("Total", "Rs. ${prices['total']!.toStringAsFixed(2)}",
            boldText: true),
      ],
    );
  }

  Widget buildSummaryRow(String label, String value, {bool boldText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: boldText ? FontWeight.bold : FontWeight.normal)),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: boldText ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final prices = calculatePriceSummary(
        productProvider.cartItems, productProvider.selectedDeliveryOption);

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: CustomButton(
        onPressed: () {
          final contactId =
              Provider.of<UserProvider>(context, listen: false).userId;

          if (contactId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceOrderScreen(
                  deliveryCharges: prices['deliveryCharge']!,
                  orderType: productProvider.selectedDeliveryOption,
                  totalBeforeTax: prices['subTotal']!,
                  taxAmount: prices['tax']!,
                  contactId: contactId, // Pass the user ID here
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User ID not found")),
            );
          }
        },
        text: "Proceed to Checkout",
        clrtext: MyColors.white,
      ),
    );
  }
}
