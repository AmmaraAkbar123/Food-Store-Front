import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/screens/product_detail/widgets/product_detail_section_widget.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/screens/product_detail/widgets/cancel_button_widget.dart';
import 'package:foodstorefront/screens/product_detail/widgets/remove_order_section_widget.dart';
import 'package:foodstorefront/screens/product_detail/widgets/special_instruction.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName; // Add a field for product name

  const ProductDetailScreen({super.key, required this.productName});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _isOptionSelected = false;
  late FocusScopeNode _focusScopeNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductByName(widget.productName);
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  void _onSelectionChanged(bool isSelected) {
    setState(() {
      _isOptionSelected = isSelected;
    });
    _focusScopeNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            final product = productProvider.products.firstWhere(
              (product) => product.name == widget.productName,
            );
            if (productProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (product == null) {
              return const Center(child: Text('No product data available'));
            } else {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        product.image.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                    leading: Container(
                      margin: EdgeInsets.all(12),
                      child: CustomCancelButton(
                        size: 45,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitleSection(product: product),
                          const SizedBox(height: 15),
                          ...product.variations.map((variation) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              // child: SelectMenuSection(
                              //   product: product,
                              //   variation: variation,
                              //   onSelectionChanged: _onSelectionChanged,
                              // ),
                            );
                          }).toList(),
                          // FrequentlyBoughtTogetherSection(product: product),
                          const SizedBox(height: 10),
                          Divider(color: MyColors.lightGrey),
                          const SizedBox(height: 10),
                          SpecialInstructionSection(),
                          SizedBox(height: 40),
                          RemoveFromOrderSection(),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: MyColors.lightGrey,
                ),
              ),
            ),
            BottomAppBar(
              color: Colors.transparent,
              child: Container(
                height: 85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: _quantity > 1 ? MyColors.primary : MyColors.grey,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: _decrementQuantity,
                        icon: Icon(
                          Icons.remove,
                          color: MyColors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    Text(
                      '$_quantity',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.primary,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: _incrementQuantity,
                        icon: Icon(
                          Icons.add,
                          size: 22,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 170,
                      height: 48,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: _isOptionSelected
                            ? MyColors.primary
                            : MyColors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
