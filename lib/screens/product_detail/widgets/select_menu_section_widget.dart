// import 'package:flutter/material.dart';
// import 'package:foodstorefront/models/dummyproduct_model.dart';
// import 'package:foodstorefront/utils/colors.dart';

// class SelectMenuSection extends StatefulWidget {
//   final Product product;
//   final ProductVariation variation;
//   final Function(bool) onSelectionChanged;

//   const SelectMenuSection({
//     super.key,
//     required this.product,
//     required this.variation,
//     required this.onSelectionChanged,
//   });

//   @override
//   State<SelectMenuSection> createState() => _SelectMenuSectionState();
// }

// class _SelectMenuSectionState extends State<SelectMenuSection> {
//   String _selectedOption = '';

//   void _onOptionSelected(String option) {
//     setState(() {
//       _selectedOption = option;
//     });
//     widget.onSelectionChanged(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 18),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           border: Border.all(color: MyColors.grey),
//           borderRadius: BorderRadius.circular(12),
//           color: MyColors.lightPink,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 16, right: 16, top: 16, bottom: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       width: 250,
//                       child: Text(
//                         widget.variation.title,
//                         style: TextStyle(
//                             overflow: TextOverflow.clip,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 18,
//                             height: 1.2),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//               ),
//               child: Text(
//                 "Select one",
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: MyColors.primary,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: widget.product.variations.map((variation) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: _buildSelectionCircle(
//                         context, variation.name, variation.price),
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectionCircle(BuildContext context, String text, String txt2) {
//     return InkWell(
//       onTap: () {
//         _onOptionSelected(text);
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             width: 22,
//             height: 22,
//             decoration: BoxDecoration(
//               color:
//                   _selectedOption == text ? MyColors.primary : MyColors.white,
//               shape: BoxShape.circle,
//               border: Border.all(color: MyColors.primary, width: 2),
//             ),
//             child: _selectedOption == text
//                 ? Icon(Icons.circle, size: 10, color: MyColors.white)
//                 : null,
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: MyColors.greyText,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           SizedBox(width: 10),
//           Text(
//             txt2,
//             style: TextStyle(
//               color: MyColors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }


// }
