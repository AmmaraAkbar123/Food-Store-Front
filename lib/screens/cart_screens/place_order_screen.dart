import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/place_order_provider.dart'; // Import your PlaceOrderProvider
import 'package:foodstorefront/provider/payment_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/user_provider.dart';
import 'package:foodstorefront/screens/cart_screens/order_confirmation_page.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  final double deliveryCharges;
  final String orderType;
  final double totalBeforeTax;
  final double taxAmount;

  const PlaceOrderScreen({
    super.key,
    required this.deliveryCharges,
    required this.orderType,
    required this.totalBeforeTax,
    required this.taxAmount,
  });

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int _selectedAddress = 0;
  int _selectedPaymentMethod = 0;

  final List<String> addresses = [
    '1 Stockton St San Francisco County US',
    'Plot 179 Lahore PK',
    'Plot 225, Lahore, PK',
    'Office no 12, Lahore, PK',
    'F7F8+9PP, Lahore, PK',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Container(
          color: MyColors.white,
          height: double.infinity,
          width: double.infinity,
          child: const Center(
            child: CircularProgressIndicator(
              color: MyColors.black,
            ),
          ),
        ),
      );

      try {
        // Fetch payment methods
        await Provider.of<PaymentProvider>(context, listen: false)
            .fetchPaymentMethods();

        // Fetch products
        await Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts();
      } catch (e) {
        // Handle the error if needed
        print('Error fetching data: $e');
      } finally {
        Navigator.of(context, rootNavigator: true)
            .pop(); // Close the loading dialog
      }
    });
  }

  Future<void> _placeOrder() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final placeOrderProvider =
        Provider.of<PlaceOrderProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      // Ensure products are fetched
      if (productProvider.products.isEmpty) {
        await productProvider.fetchProducts();
      }

      // Convert the cart items map to a list of products
      final cartProducts = productProvider.cartItems.keys.toList();

      // Fetch the user's name from UserProvider
      final deliveredTo = userProvider.user?.name ?? 'Unknown';

      // Place the order using PlaceOrderProvider
      await placeOrderProvider.createOrder(
        context,
        cartProducts,
        widget.orderType,
        widget.deliveryCharges,
        deliveredTo,
      );
      // Clear the cart after successful order placement
      productProvider.clearCart();
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OrderConfirmationPage()),
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Handle adding new address
                    },
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAddress = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedAddress == index
                              ? MyColors.GreyWithOp
                              : MyColors.GreyWithOp,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            _selectedAddress == index
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: _selectedAddress == index
                                ? MyColors.black
                                : MyColors.greyText,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: _selectedAddress == index
                                      ? MyColors.black
                                      : MyColors.greyText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                addresses[index],
                                style: const TextStyle(
                                  color: MyColors.greyText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Consumer<PaymentProvider>(
                builder: (context, paymentProvider, child) {
                  final paymentMethods = paymentProvider.paymentMethods;
                  return Column(
                    children: List.generate(paymentMethods.length, (index) {
                      final method = paymentMethods[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = method.id;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedPaymentMethod == method.id
                                  ? MyColors.GreyWithOp
                                  : MyColors.GreyWithOp,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _selectedPaymentMethod == method.id
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                color: _selectedPaymentMethod == method.id
                                    ? MyColors.black
                                    : MyColors.greyText,
                              ),
                              const SizedBox(width: 10),
                              Image.network(
                                method.logo,
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                method.name,
                                style: TextStyle(
                                  color: _selectedPaymentMethod == method.id
                                      ? MyColors.black
                                      : MyColors.greyText,
                                  fontWeight:
                                      _selectedPaymentMethod == method.id
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildBottomBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: CustomButton(
        onPressed: _placeOrder,
        text: "Place Order",
        clrtext: MyColors.white,
      ),
    );
  }
}
