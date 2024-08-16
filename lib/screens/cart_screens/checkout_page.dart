import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/payment_provider.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/screens/cart_screens/order_confirmation_page.dart';
import 'package:foodstorefront/screens/login%20and%20signup/login/widgets/custom_button.dart';
import 'package:foodstorefront/utils/colors.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
    // Fetch payment methods when the page is initialized
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
        await Provider.of<PaymentProvider>(context, listen: false)
            .fetchPaymentMethods();
      } catch (e) {
        // Handle the error if needed
      } finally {
        Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
      }
    });
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
                                method
                                    .logo, // Use Image.network for dynamic URLs
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderConfirmationPage()),
        ),
        text: "Place Order",
        clrtext: MyColors.white,
      ),
    );
  }
}
