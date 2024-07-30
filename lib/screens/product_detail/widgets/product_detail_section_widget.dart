import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/utils/colors.dart';

class ProductTitleSection extends StatelessWidget {
  final ProductModel product;

  const ProductTitleSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    overflow: TextOverflow.clip,
                    height: 1,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'Rs. ${product.price}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12,
                    color: MyColors.black,
                  ),
                ),
                Text(
                  'Rs. ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: MyColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          // "My Description",
          product.description as String,
          style: const TextStyle(
              height: 1.1,
              fontSize: 13,
              color: MyColors.greyText,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 8),
        Divider(
          color: MyColors.lightGrey,
        ),
      ],
    );
  }
}
