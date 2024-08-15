import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/separater.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';

import '../login and signup/login/widgets/custom_button.dart';
import 'checkout_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.white,
      elevation: 0,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
        product.image.thumbnail ?? 'https://via.placeholder.com/70',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildProductDetails(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
        Text(
          'Code: ${product.price}',
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          'Rs. ${product.price.toString()}',
          style: TextStyle(color: MyColors.primary),
        ),
      ],
    );
  }

  Widget buildQuantityController(
      BuildContext context, ProductModel product, int quantity) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (quantity > 1) {
              Provider.of<ProductProvider>(context, listen: false)
                  .removeProduct(product);
            } else {
              Provider.of<ProductProvider>(context, listen: false)
                  .removeFromCart(context, product);
            }
          },
        ),
        Text(
          '$quantity',
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            final provider =
                Provider.of<ProductProvider>(context, listen: false);
            provider.addProduct(
              product,
            ); // Use dynamic quantity
          },
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
            "Pick Up", "Pick Up", productProvider.selectedDeliveryOption,
            (value) {
          productProvider.setDeliveryOption(value!);
        }),
      ],
    );
  }

  Widget buildDeliveryOptionTile(String title, String value, String groupValue,
      Function(String?) onChanged) {
    return InkWell(
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
    double itemsPrice = cartItems.entries
        .fold(0, (sum, item) => sum + (item.key.price) * item.value);
    double taxRate = 0.07;
    double tax = itemsPrice * taxRate;
    double subTotal = itemsPrice + tax;
    double deliveryCharge = deliveryOption == "Delivery" ? 50.0 : 0.0;
    double total = subTotal + deliveryCharge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSummaryRow("Items Price", "Rs. ${itemsPrice.toStringAsFixed(2)}"),
        buildSummaryRow("Vat/Tax", "Rs. ${tax.toStringAsFixed(2)}"),
        SizedBox(height: 5),
        MySeparator(),
        SizedBox(height: 5),
        buildSummaryRow("Subtotal", "Rs. ${subTotal.toStringAsFixed(2)}",
            boldText: true),
        buildSummaryRow(
            "Delivery Charge", "Rs. ${deliveryCharge.toStringAsFixed(2)}"),
        SizedBox(height: 5),
        MySeparator(),
        SizedBox(height: 5),
        buildSummaryRow("Total", "Rs. ${total.toStringAsFixed(2)}",
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
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: CustomButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                ),
            text: "Proceed to Checkout",
            clrtext: MyColors.white));
  }
}
