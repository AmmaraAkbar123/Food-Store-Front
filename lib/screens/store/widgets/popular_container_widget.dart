// import 'package:flutter/material.dart';
// import 'package:foodstorefront/models/product_model.dart';
// import 'package:foodstorefront/screens/store/widgets/store_product.dart';
// import 'package:foodstorefront/utils/colors.dart';

// class PopularContainerWidget extends StatelessWidget {
//   final ProductModel product;

//   const PopularContainerWidget({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.white,
//       ),
//       padding: const EdgeInsets.all(4),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment:
//             CrossAxisAlignment.start, // Added to ensure alignment
//         children: [
//           StoreProduct(productImage: product.image),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 7),
//               Text(
//                 product.name,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 children: [
//                   Text(
//                     'Rs. ${product.price}',
//                     style: const TextStyle(
//                       color: MyColors.primary,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     'Rs. ${product.price}',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       decoration: TextDecoration.lineThrough,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
