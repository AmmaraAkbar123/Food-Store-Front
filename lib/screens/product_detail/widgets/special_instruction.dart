import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';

class SpecialInstructionSection extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final int maxLength = 500;

  SpecialInstructionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        _controller.text = productProvider.specialInstructions;
        _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Special Instructions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              "Please let us know if you are allergic to anything or if we need to avoid anything",
              style: TextStyle(
                  fontSize: 13,
                  color: MyColors.greyText,
                  overflow: TextOverflow.clip),
            ),
            SizedBox(height: 20),
            Container(
              height: 90,
              child: TextFormField(
                controller: _controller,
                maxLines: 3,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  labelText: "e.g. no mayo",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: MyColors.greyText, fontSize: 16),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: MyColors.grey2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: MyColors.lightGrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: MyColors.black,
                    ),
                  ),
                ),
                onChanged: (text) {
                  productProvider.updateSpecialInstructions(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_controller.text.length}/$maxLength',
                  style: TextStyle(fontSize: 12, color: MyColors.black87),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
