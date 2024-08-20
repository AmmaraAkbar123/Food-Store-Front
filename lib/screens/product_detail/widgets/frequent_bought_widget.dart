import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/screens/product_detail/widgets/reuired_optional_button.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:provider/provider.dart';

class FrequentlyBoughtTogetherSection extends StatelessWidget {
  final ProductModel product;

  const FrequentlyBoughtTogetherSection({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Frequently bought together',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            RequiredOptionalButton(
              text: 'Optional',
              color: MyColors.grey2,
              txtColor: MyColors.greyText,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Other customers also ordered these',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: product.variations.length,
              itemBuilder: (context, index) {
                final variation = product.variations[index];
                final isSelected =
                    productProvider.selectedIndices.contains(index);
                return GestureDetector(
                  onTap: () {
                    productProvider.toggleSelection(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isSelected ? MyColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: MyColors.primary, width: 2),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Icon(Icons.check,
                                      size: 12, color: MyColors.white))
                              : null,
                        ),
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            ImagesStrings.burgerimage,
                            height: 35,
                            width: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            variation.compareAtPrice,
                            style: const TextStyle(
                              color: MyColors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '\$${variation.defaultSellPrice}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: MyColors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
