// import 'package:flutter/material.dart';
// import 'package:foodstorefront/models/dummyproduct_model.dart';

// class ProductVariationSection extends StatelessWidget {
//   final Product product;

//   const ProductVariationSection({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Variation',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         for (var variation in product.variations)
//           ListTile(
//             title: Text(variation.name),
//             trailing: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   'Rs. ',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Rs. ${variation.oldPrice.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                     decoration: TextDecoration.lineThrough,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }
