import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';

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
      bottomNavigationBar: buildBottomBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "My Cart",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Widget buildBody(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildCartItemsList(productProvider),
                const SizedBox(height: 50),
                buildDeliveryOptions(productProvider),
                const Divider(),
                buildPriceSummary(productProvider.cartItems,
                    productProvider.selectedDeliveryOption),
              ],
            ),
          ),
        );
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
            buildProductDetails(product),
            const Spacer(),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          Provider.of<ProductProvider>(context, listen: false)
              .addProduct(product);
        },
      ),
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
          productProvider.updateDeliveryOption(value!);
        }),
        buildDeliveryOptionTile(
            "Pick Up", "Pick Up", productProvider.selectedDeliveryOption,
            (value) {
          productProvider.updateDeliveryOption(value!);
        }),
      ],
    );
  }

  Widget buildDeliveryOptionTile(
      String title, String value, String groupValue, Function(String?) onChanged) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }

  Widget buildPriceSummary(
      Map<ProductModel, int> cartItems, String deliveryOption) {
    double subtotal = cartItems.entries.fold(
        0, (sum, item) => sum + (item.key.price) * item.value);
    double taxRate = 0.07;
    double tax = subtotal * taxRate;
    double total = subtotal + tax;
    String deliveryCharge =
        deliveryOption == "Delivery" ? "Rs. 50.00" : "Free";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Price Summary",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildSummaryRow("Subtotal", "Rs. ${subtotal.toStringAsFixed(2)}"),
        buildSummaryRow("Tax", "Rs. ${tax.toStringAsFixed(2)}"),
        buildSummaryRow("Delivery Charge", deliveryCharge),
        const Divider(),
        buildSummaryRow("Total", "Rs. ${total.toStringAsFixed(2)}",
            isTotal: true),
      ],
    );
  }

  Widget buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: ElevatedButton(
        onPressed: () {
          // Handle checkout
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          "Proceed to Checkout",
          style: TextStyle(fontSize: 18, color: MyColors.white),
        ),
      ),
    );
  }
}
