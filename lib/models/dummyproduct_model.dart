// import 'package:foodstorefront/utils/images_strings.dart';

// class Product {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final String description;
//   final double price;
//   final double? oldPrice;
//   final bool isPopular;

//   final List<ProductVariation> variations;
//   final List<Product> frequentlyBoughtTogether;

//   Product({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.description,
//     required this.price,
//     this.isPopular = false,
//     required this.oldPrice,
//     required this.variations,
//     required this.frequentlyBoughtTogether,
//   });
// }

// class ProductVariation {
//   final String title;
//   final String name;
//   final String ImagUrl;
//   final String price;
//   final double oldPrice;

//   ProductVariation({
//     required this.title,
//     required this.name,
//     required this.price,
//     required this.oldPrice,
//     required this.ImagUrl,
//   });
// }

// class FrequentlyBoughtTogether {
//   final String title;
//   final String name;
//   final String price;
//   final double oldPrice;

//   FrequentlyBoughtTogether({
//     required this.title,
//     required this.name,
//     required this.price,
//     required this.oldPrice,
//   });
// }

// //// popular deals data///////////
// ///
// Future<List<Product>> fetchProducts() async {
//   // Simulate fetching data from an API after 2 seconds delay
//   await Future.delayed(Duration(seconds: 2));

//   // Replace with actual API call to fetch products
//   return [
//     Product(
//       id: '1',
//       name: 'Burger',
//       imageUrl: ImagesStrings.burgerimage2,
//       description: 'Delicious burger with cheese ',
//       price: 100,
//       oldPrice: 120,
//       isPopular: true,
//       variations: [],
//       frequentlyBoughtTogether: [],
//     ),
//     Product(
//       id: '2',
//       name: 'Pizza',
//       imageUrl: ImagesStrings.burgerimage2,
//       description: 'Pepperoni pizza with extra cheese',
//       price: 200,
//       oldPrice: 220,
//       variations: [],
//       frequentlyBoughtTogether: [],
//     ),
//     Product(
//       id: '3',
//       name: 'Fries',
//       imageUrl: ImagesStrings.burgerimage,
//       description: 'Crispy fries with ketchup',
//       price: 50,
//       variations: [],
//       frequentlyBoughtTogether: [],
//       oldPrice: 80,
//     ),
//     Product(
//       id: '4',
//       name: 'Ice Cream',
//       imageUrl: ImagesStrings.burgerimage2,
//       description: 'Vanilla ice cream with chocolate syrup',
//       price: 80,
//       variations: [],
//       frequentlyBoughtTogether: [],
//       oldPrice: 90,
//     ),
//     Product(
//       id: '5',
//       name: 'Ice Cream',
//       imageUrl: ImagesStrings.burgerimage2,
//       description: 'Vanilla ice cream with chocolate syrup',
//       price: 80,
//       variations: [],
//       frequentlyBoughtTogether: [],
//       oldPrice: 90,
//     ),
//     Product(
//       id: '6',
//       name: 'Ice Cream',
//       imageUrl: ImagesStrings.burgerimage2,
//       description: 'Vanilla ice cream with chocolate syrup',
//       price: 80,
//       variations: [],
//       frequentlyBoughtTogether: [],
//       oldPrice: 90,
//     ),
//   ];
// }

// ///// summerdeals data ////////////
// Future<List<Product>> fetchSummerDeals() async {
//   // Simulate fetching summer deals from an API
//   await Future.delayed(const Duration(seconds: 2));
//   return List.generate(4, (index) {
//     return Product(
//       id: 'deal-$index',
//       name: 'Summer Deal $index',
//       imageUrl: ImagesStrings.burgerimage,
//       description:
//           'Description for summer deal Pepperoni pizza with extra cheese gfrdhtgf hfhgf thftfy sewsetr juhkujhjk $index',
//       price: 99.99 + index,
//       oldPrice: 119.99 + index,
//       isPopular: index % 2 == 0,
//       variations: [],
//       frequentlyBoughtTogether: [],
//     );
//   });
// }

// //requently bought and variations data

// Future<Product> fetchProductDetails(String productId) async {
//   // Placeholder for API call
//   await Future.delayed(const Duration(seconds: 2));
//   return Product(
//     id: productId,
//     name: "Summer Deal 1",
//     imageUrl: ImagesStrings.burgerimage,
//     description: 'ShotGun Burger(Org/Hot)+Original Fries(Plain/Masala)',
//     price: 192.0,
//     oldPrice: 240.0,
//     variations: [
//       ProductVariation(
//           title: "Choose Your ShotGun Burger",
//           name: 'ShotGun Original',
//           price: "Free",
//           oldPrice: 240.0,
//           ImagUrl: ImagesStrings.burgerimage2),
//       ProductVariation(
//           name: 'ShotGun Hot',
//           price: "Free",
//           ImagUrl: ImagesStrings.burgerimage,
//           oldPrice: 480.0,
//           title: 'Choose Your Fries Flavour'),
//     ],
//     frequentlyBoughtTogether: [
//       Product(
//         id: '1',
//         name: 'Paratha',
//         imageUrl: ImagesStrings.burgerimage2,
//         price: 50.0,
//         description: 'Single/Double',
//         oldPrice: 66,
//         variations: [
//           ProductVariation(
//               name: 'Coca-Cola- 500 ml',
//               ImagUrl: ImagesStrings.burgerimage,
//               price: "+ Rs. 199.0",
//               oldPrice: 240.0,
//               title: 'Choose Your Pizza'),
//           ProductVariation(
//               name: 'Garlic Mayo',
//               price: "+ Rs. 120.0",
//               ImagUrl: ImagesStrings.burgerimage2,
//               oldPrice: 480.0,
//               title: 'Choose Your Type'),
//           ProductVariation(
//               name: "Coca-Cola- 1 Litre",
//               price: "+ Rs. 299.0",
//               ImagUrl: ImagesStrings.burgerimage,
//               oldPrice: 480.0,
//               title: 'Choose Your Type'),
//         ],
//         frequentlyBoughtTogether: [],
//       ),
//     ],
//   );
// }
