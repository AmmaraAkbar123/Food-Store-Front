import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class GridProductImage extends StatelessWidget {
  final String productImage;

  const GridProductImage({
    super.key,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            productImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 160,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MyColors.lightGrey)),
                height: 160,
                width: double.infinity,
                child: const Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
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
            child: const Center(
              child: Icon(
                Icons.add,
                color: MyColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  
  
  }
}
