// import 'package:flutter/material.dart';
// import 'package:foodstorefront/models/dummyproduct_model.dart';
// import 'package:foodstorefront/screens/product_detail/product_detail_page.dart';
// import 'package:foodstorefront/utils/colors.dart';
// import 'package:foodstorefront/widgets/popular_container_widget.dart';

// class PopularContentWidget extends StatefulWidget {
//   final String apiEndpoint;
//   final String title;

//   const PopularContentWidget({
//     Key? key,
//     required this.apiEndpoint,
//     required this.title,
//   }) : super(key: key);

//   @override
//   State<PopularContentWidget> createState() => _PopularContentWidgetState();
// }

// class _PopularContentWidgetState extends State<PopularContentWidget> {
//   late Future<List<Product>> _futureProducts;

//   @override
//   void initState() {
//     super.initState();
//     _futureProducts = fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Product>>(
//       future: _futureProducts,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text('Error fetching data'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No data available'));
//         } else {
//           List<Product> products = snapshot.data!;
//           return CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     top: 20,
//                     left: 16,
//                     right: 16,
//                     bottom: 16,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.local_fire_department,
//                             color: MyColors.red,
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             widget.title,
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       const Text(
//                         "Most ordered right now",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                       const SizedBox(height: 15),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 sliver: SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 5,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 0.78,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       return GestureDetector(
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductDetailScreen(
//                               productId: products[index].id,
//                             ),
//                           ),
//                         ),
//                         child: PopularContainerWidget(
//                           product: products[index],
//                         ),
//                       );
//                     },
//                     childCount: products.length,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
