import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/radio_provider.dart';
import 'package:foodstorefront/screens/product_detail/widgets/custom_radio_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/utils/colors.dart';

class RemoveFromOrderSection extends StatelessWidget {
  const RemoveFromOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // To align text to the start
        children: [
          Text(
            "If this product is not available",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
                border: Border.all(color: MyColors.grey),
                borderRadius: BorderRadius.circular(8),
                color: MyColors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<RadioProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        getSelectedText(provider.selectedValue),
                        style: TextStyle(fontSize: 14),
                      );
                    },
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: MyColors.primary,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: MyColors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
          child: Consumer<RadioProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: MyColors.grey,
                      margin: EdgeInsets.only(
                        bottom: 26,
                      ),
                    ),
                  ),
                  Text(
                    "If this product is not available",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    title: Text("Remove it from my order"),
                    leading: CustomRadio(
                      isSelected: provider.selectedValue == 0,
                      onTap: () {
                        provider.updateSelectedValue(0);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Cancel the entire order"),
                    leading: CustomRadio(
                      isSelected: provider.selectedValue == 1,
                      onTap: () {
                        provider.updateSelectedValue(1);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Call me & Confirm"),
                    leading: CustomRadio(
                      isSelected: provider.selectedValue == 2,
                      onTap: () {
                        provider.updateSelectedValue(2);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Apply", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust the radius as needed
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

String getSelectedText(int selectedValue) {
  switch (selectedValue) {
    case 0:
      return "Remove it from my order";
    case 1:
      return "Cancel the entire order";
    case 2:
      return "Call me & Confirm";
    default:
      return "Remove it from my order";
  }
}
