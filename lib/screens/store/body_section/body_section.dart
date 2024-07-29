import 'package:flutter/material.dart';
import 'package:foodstorefront/models/category_model.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/screens/product_detail/product_detail_Screen.dart';
import 'package:foodstorefront/screens/store/body_section/widgets/grid_card.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/screens/store/body_section/widgets/list_card.dart';

class BodySection extends StatelessWidget {
  final int categoryIndex;
  final bool showGrid;
  final Category category;
  final List<ProductModel> products;

  const BodySection({
    super.key,
    required this.categoryIndex,
    required this.showGrid,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      color: MyColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSectionTileHeader(context),
          if (categoryIndex == 0) buildSubtitle(context),
          categoryIndex == 0 ? buildGridView(context) : buildListView(context),
        ],
      ),
    );
  }

  Widget buildSectionTileHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10 // Reduced top margin
          ),
      child: Row(
        children: [
          if (categoryIndex == 0) Icon(Icons.whatshot, color: MyColors.red),
          const SizedBox(width: 4), // Reduced space between the icon and text
          Text(
            category.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildSubtitle(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20), // Reduced top padding
      child: Text('This is the subtitle for the first category',
          style: TextStyle(color: MyColors.greyText)),
    );
  }

  Widget buildGridView(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero, // Removed padding
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 3.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      productName: product.name,
                    ))),
            child: GridCard(product: product));
      },
    );
  }

  Widget buildListView(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero, // Removed padding
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      productName: product.name,
                    ))),
            child: ListCard(product: product));
      },
    );
  }
}
