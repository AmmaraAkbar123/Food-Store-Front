import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      'Rs. ${product.price}',
                      style: const TextStyle(
                          fontSize: 14, color: MyColors.primary),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Rs. ${product.price}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                HtmlWidget(
                  product.description.toString(),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.clip,
                    color: MyColors.greyText,
                    fontWeight: FontWeight.w500,
                  ),
                  customStylesBuilder: (element) {
                    return {
                      'max-lines': '2',
                      'text-overflow': 'ellipsis',
                    };
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.whatshot,
                        color: MyColors.red,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Popular',
                        style:
                            TextStyle(color: MyColors.greyText, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: product.image.thumbnail != null
                      ? Image.network(
                          product.image.thumbnail,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 110,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: MyColors.lightGrey),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: MyColors.lightGrey),
                              ),
                              height: 110,
                              width: double.infinity,
                              child: const Icon(
                                Icons.error,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.lightGrey),
                          ),
                          height: 110,
                          width: double.infinity,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      final isAdded = productProvider.isProductAdded(product);

                      return GestureDetector(
                        onTap: () {
                          if (isAdded) {
                            productProvider.removeFromCart(product);
                          } else {
                            productProvider.addToCart(product);
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              isAdded ? Icons.check : Icons.add,
                              color: MyColors.primary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
