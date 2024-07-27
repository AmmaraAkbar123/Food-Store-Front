// import 'package:flutter/material.dart';
// import 'package:foodstorefront/models/product_model.dart';
// import 'package:foodstorefront/widgets/deal_card_widget.dart';

// class SummerDealsWidget extends StatefulWidget {
//   const SummerDealsWidget({Key? key}) : super(key: key);

//   @override
//   State<SummerDealsWidget> createState() => _SummerDealsWidgetState();
// }

// class _SummerDealsWidgetState extends State<SummerDealsWidget> {
//   late Future<List<Product>> _futureSummerProducts;
//   @override
//   void initState() {
//     super.initState();
//     _futureSummerProducts = fetchSummerDeals();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Product>>(
//       future: _futureSummerProducts,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text('Error loading summer deals'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No summer deals available'));
//         } else {
//           final deals = snapshot.data!;
//           return ListView(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 30, left: 10, right: 10),
//                       child: const Text(
//                         "Summer Deals",
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Column(
//                       children: List.generate(deals.length, (index) {
//                         return Column(
//                           children: [
//                             if (index > 0)
//                               const Divider(indent: 12, endIndent: 12),
//                             DealCard(product: deals[index]),
//                           ],
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
