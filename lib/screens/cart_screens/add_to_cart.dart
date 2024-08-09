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
  String selectedDeliveryOption = "Delivery";

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
                      return buildShoppingItemCard(context, product);
                    },
                  ),
                  SizedBox(height: 50),
                  buildDeliveryOptions(),
                  Divider(),
                  buildPriceSummary(productProvider.cartItems),
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

  Widget buildShoppingItemCard(BuildContext context, ProductModel product) {
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
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .removeFromCart(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Option",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            buildDeliveryOption("Delivery"),
            buildDeliveryOption("Self Pickup"),
          ],
        ),
      ],
    );
  }

  Widget buildDeliveryOption(String title) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: selectedDeliveryOption,
          onChanged: (value) {
            setState(() {
              selectedDeliveryOption = value!;
            });
          },
          activeColor: Colors.green,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget buildPriceSummary(Map<ProductModel, int> cartItems) {
    double itemsPrice = 0;
    cartItems.forEach((product, quantity) {
      itemsPrice += (product.price ?? 0) * quantity;
    });

    double vatTax = itemsPrice * 0.06; // Example tax calculation
    double subtotal = itemsPrice + vatTax;
    double deliveryFee = selectedDeliveryOption == "Delivery" ? 0 : 0;

    return Column(
      children: [
        buildPriceItem("Items Price", "Rs. ${itemsPrice.toStringAsFixed(2)}"),
        buildPriceItem("Vat/Tax", "(+) Rs. ${vatTax.toStringAsFixed(2)}"),
        Divider(),
        buildPriceItem("Subtotal", "Rs. ${subtotal.toStringAsFixed(2)}"),
        buildPriceItem(
            "Delivery Fee", "(+) Rs. ${deliveryFee.toStringAsFixed(2)}"),
        Divider(),
        TotalAmount(amount: subtotal + deliveryFee),
      ],
    );
  }

  Widget buildPriceItem(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TotalAmount extends StatelessWidget {
  final double amount;

  const TotalAmount({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total Amount",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Text(
          "Rs. ${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
