import 'package:flutter/material.dart';

class AddToCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.grid_view_rounded, color: Colors.green),
        ),
        title: Text(
          "Shopping Bag",
          style: TextStyle(color: Colors.green),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "3 Items",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildShoppingItemCard(
                    imageUrl:
                        "assets/images/meal.jpg", // Replace with your asset path
                    title: "Healthy Meal",
                    code: "glf23g",
                    price: "50.00",
                  ),
                  buildShoppingItemCard(
                    imageUrl:
                        "assets/images/buffet.jpg", // Replace with your asset path
                    title: "Dinner Buffet",
                    code: "2FG158",
                    price: "250.00",
                  ),
                  buildShoppingItemCard(
                    imageUrl:
                        "assets/images/seafood.jpg", // Replace with your asset path
                    title: "Seafood Buffet",
                    code: "foods321",
                    price: "250.00",
                  ),
                ],
              ),
            ),
            Divider(),
            buildDeliveryOptions(),
            Divider(),
            buildPriceSummary(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle checkout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                "Process to Checkout",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShoppingItemCard({
    required String imageUrl,
    required String title,
    required String code,
    required String price,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(code),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "USD $price",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle decrement
                      },
                      icon: Icon(Icons.remove),
                      color: Colors.green,
                    ),
                    Text("1"),
                    IconButton(
                      onPressed: () {
                        // Handle increment
                      },
                      icon: Icon(Icons.add),
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Delivery Option",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            buildDeliveryOption("Delivery", true),
            SizedBox(width: 16),
            buildDeliveryOption("Self Pickup", false),
          ],
        ),
      ],
    );
  }

  Widget buildDeliveryOption(String title, bool isSelected) {
    return Row(
      children: [
        Radio(
          value: isSelected,
          groupValue: true,
          onChanged: (value) {
            // Handle selection
          },
          activeColor: Colors.green,
        ),
        Text(title),
      ],
    );
  }

  Widget buildPriceSummary() {
    return Column(
      children: [
        buildPriceItem("Items Price", "USD 517.39"),
        buildPriceItem("Vat/Tax", "(+) USD 32.61"),
        Divider(),
        buildPriceItem("Subtotal", "USD 550.00"),
        buildPriceItem("Delivery Fee", "(+) USD 0.00"),
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
