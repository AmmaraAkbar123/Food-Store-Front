import 'package:flutter/material.dart';
import 'package:foodstorefront/models/category_model.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/screens/product_detail/product_detail_Screen.dart';
import 'package:foodstorefront/screens/store/widgets/grid_deal_card.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/widgets/list_card.dart';

class CategorySection extends StatelessWidget {
  final int categoryIndex;
  final bool showGrid;
  final Category category;
  final List<ProductModel> products;

  const CategorySection({
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
      margin: const EdgeInsets.only(bottom: 12),
      color: MyColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSectionTileHeader(context),
          categoryIndex == 0 ? buildGridView() : buildListView(),
        ],
      ),
    );
  }

  Widget buildSectionTileHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      child: Text(
        category.name,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildGridView() {
    return SizedBox(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10.0,
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
              child: GridDealCard(product: product));
        },
      ),
    );
  }

  Widget buildListView() {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
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
      ),
    );
  }
}
