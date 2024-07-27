// import 'package:flutter/material.dart';
// import 'package:foodstorefront/models/dummyproduct_model.dart';
// import 'package:foodstorefront/utils/colors.dart';
// import 'package:foodstorefront/widgets/product_detail_widgets/reuired_optional_button.dart';

// class FrequentlyBoughtTogetherSection extends StatefulWidget {
//   final Product product;

//   const FrequentlyBoughtTogetherSection({Key? key, required this.product})
//       : super(key: key);

//   @override
//   _FrequentlyBoughtTogetherSectionState createState() =>
//       _FrequentlyBoughtTogetherSectionState();
// }

// class _FrequentlyBoughtTogetherSectionState
//     extends State<FrequentlyBoughtTogetherSection> {
//   Set<int> _selectedIndices = {};

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Frequently bought together',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             RequiredOptionalButton(
//               text: 'Optional',
//               color: MyColors.grey2,
//               txtColor: MyColors.greyText,
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Other customers also ordered these',
//           style: const TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: widget.product.frequentlyBoughtTogether.length,
//           itemBuilder: (context, index) {
//             final frequentlyBoughtProduct =
//                 widget.product.frequentlyBoughtTogether[index];
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: frequentlyBoughtProduct.variations.length,
//                   itemBuilder: (context, subIndex) {
//                     final variation =
//                         frequentlyBoughtProduct.variations[subIndex];
//                     final isSelected = _selectedIndices.contains(subIndex);
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           if (isSelected) {
//                             _selectedIndices.remove(subIndex);
//                           } else {
//                             _selectedIndices.add(subIndex);
//                           }
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 30),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 20,
//                               height: 20,
//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? MyColors.primary
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(
//                                     color: MyColors.primary, width: 2),
//                               ),
//                               child: isSelected
//                                   ? Center(
//                                       child: Icon(Icons.check,
//                                           size: 12, color: MyColors.white))
//                                   : null,
//                             ),
//                             SizedBox(width: 10),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8.0),
//                               child: variation.ImagUrl != null
//                                   ? Image.asset(
//                                       variation.ImagUrl!,
//                                       height: 35,
//                                       width: 35,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Icon(Icons
//                                       .image_not_supported), // Placeholder or error handling
//                             ),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Text(
//                                 variation.name ??
//                                     'Variation Name Not Available',
//                                 style: const TextStyle(
//                                   color: MyColors.black87,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               variation.price ?? 'Price Not Available',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: MyColors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.arrow_downward,
//                       color: MyColors.primary,
//                       size: 17,
//                     ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       "View more",
//                       style: TextStyle(color: MyColors.primary),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
