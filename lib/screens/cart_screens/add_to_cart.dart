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
    Provider.of<ProductProvider>(context, listen: false)
        .loadCartAndDeliveryOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: productProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final product =
                          productProvider.cartItems.keys.elementAt(index);
                      return buildShoppingItemCard(context, product,
                          productProvider.cartItems[product]!);
                    },
                  ),
                  SizedBox(height: 50),
                  buildDeliveryOptions(productProvider),
                  Divider(),
                  buildPriceSummary(productProvider.cartItems,
                      productProvider.selectedDeliveryOption),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
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
            padding: EdgeInsets.symmetric(vertical: 16),
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text(
            "Proceed to Checkout",
            style: TextStyle(fontSize: 18, color: MyColors.white),
          ),
        ),
      ),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image.thumbnail ?? 'https://via.placeholder.com/70',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name ?? 'Unknown',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Code: ${product.price ?? 'N/A'}',
                    style: TextStyle(color: Colors.grey)),
                Text('Rs. ${product.price?.toString() ?? 'N/A'}',
                    style: TextStyle(color: MyColors.primary)),
              ],
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .removeProduct(product);
                  },
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .addProduct(product);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryOptions(ProductProvider productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Delivery Options",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        RadioListTile<String>(
          title: Text("Delivery"),
          value: "Delivery",
          groupValue: productProvider.selectedDeliveryOption,
          onChanged: (value) {
            if (value != null) {
              productProvider.updateDeliveryOption(value);
            }
          },
        ),
        RadioListTile<String>(
          title: Text("Pick Up"),
          value: "Pick Up",
          groupValue: productProvider.selectedDeliveryOption,
          onChanged: (value) {
            if (value != null) {
              productProvider.updateDeliveryOption(value);
            }
          },
        ),
      ],
    );
  }

  Widget buildPriceSummary(
      Map<ProductModel, int> cartItems, String deliveryOption) {
    // Calculate subtotal, tax, and total
    double subtotal = 0;
    double taxRate = 0.07; // Example tax rate of 7%

    cartItems.forEach((product, quantity) {
      subtotal += (product.price ?? 0) * quantity;
    });

    double tax = subtotal * taxRate;
    double total = subtotal + tax;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        buildSummaryRow("Subtotal", "Rs. ${subtotal.toStringAsFixed(2)}"),
        buildSummaryRow("Tax", "Rs. ${tax.toStringAsFixed(2)}"),
        buildSummaryRow("Delivery Charge",
            deliveryOption == "Delivery" ? "Rs. 50.00" : "Free"),
        Divider(),
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
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
