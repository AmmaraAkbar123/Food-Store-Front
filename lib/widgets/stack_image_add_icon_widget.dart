import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class StackImagewithAddIconWidget extends StatelessWidget {
  const StackImagewithAddIconWidget({
    super.key,
    required this.productImage,
  });

  final String productImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            productImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
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
