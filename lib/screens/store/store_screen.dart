import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstorefront/models/category_model.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/provider/business_provider.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/provider/product_provider.dart';
import 'package:foodstorefront/provider/store_provider.dart';
import 'package:foodstorefront/screens/store/body_section/category_section.dart';
import 'package:foodstorefront/screens/drawer/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:foodstorefront/screens/store/app_bar/custom_appbar.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:foodstorefront/utils/text_theme.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  late AutoScrollController scrollController;
  TabController? tabController;
  final double expandedHeight = 400.0;
  final double collapsedHeight = kToolbarHeight;

  final listViewKey = RectGetter.createGlobalKey();
  Map<int, dynamic> itemKeys = {};
  bool pauseRectGetterIndex = false;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();

    scrollController = AutoScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    await Future.wait([
      Provider.of<BusinessProvider>(context, listen: false).fetchBusinessData(),
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories(),
      Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
    ]);

    final categories = Provider.of<CategoryProvider>(context, listen: false)
            .categories
            ?.data ??
        [];
    if (categories.isNotEmpty) {
      tabController = TabController(
        length: categories.length,
        vsync: this,
      );
    }

    setState(() {
      isLoading = false; // Set loading to false when data is fetched
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  List<int> getVisibleItemsIndex() {
    List<int> visibleItems = [];
    for (int i = 0; i < itemKeys.length; i++) {
      var key = itemKeys[i];
      var context = key.currentContext;
      if (context != null) {
        var rect = RectGetter.getRectFromKey(key);
        if (rect != null) {
          var screenHeight = MediaQuery.of(context).size.height;
          if (rect.top < screenHeight && rect.bottom > 500) {
            visibleItems.add(i);
          }
        }
      }
    }
    return visibleItems;
  }

  bool onScrollNotification(ScrollNotification notification) {
    final deliveryInfoProvider =
        Provider.of<DeliveryInfoProvider>(context, listen: false);
    if (pauseRectGetterIndex) return true;

    List<int> visibleItems = getVisibleItemsIndex();
    if (visibleItems.isNotEmpty) {
      int middleIndex = visibleItems.first;

      for (int index in visibleItems) {
        if (index != tabController!.index) {
          double difference = (index - tabController!.index).abs().toDouble();
          if (difference < 1) {
            middleIndex = index;
          }
        }
      }

      if (tabController!.index != middleIndex) {
        tabController!.animateTo(middleIndex);
      }
    }

    deliveryInfoProvider.setAppBarExpanded(notification.metrics.pixels > 200);

    return false;
  }

  void animateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    tabController!.animateTo(index);
    scrollController
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
        .then((value) => pauseRectGetterIndex = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, ProductProvider>(
      builder: (context, categoryProvider, productProvider, child) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = categoryProvider.categoryModel?.data ?? [];
        final products = productProvider.products;

        return Scaffold(
          backgroundColor: MyColors.lightGrey,
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: MyColors.primary),
            backgroundColor: MyColors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
            title: Consumer<DeliveryInfoProvider>(
              builder: (context, deliveryInfoProvider, child) {
                return deliveryInfoProvider.isAppBarExpanded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery",
                            style: MyTextTheme.lightTextTheme.headlineSmall,
                          ),
                          Text("10-25 min",
                              style: MyTextTheme.lightTextTheme.bodySmall),
                        ],
                      )
                    : const SizedBox.shrink(); // Hide the title when collapsed
              },
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: [
                    Icon(Icons.favorite_outline),
                    SizedBox(width: 12),
                    Icon(Icons.share_outlined),
                    SizedBox(width: 12),
                    Icon(Icons.search_outlined)
                  ],
                ),
              ),
            ],
          ),
          drawer: MyDrawer(),
          extendBodyBehindAppBar: true,
          body: RectGetter(
            key: listViewKey,
            child: NotificationListener<ScrollNotification>(
              onNotification: onScrollNotification,
              child: buildSliverScrollView(categories, products),
            ),
          ),
        );
      },
    );
  }

  Widget buildSliverScrollView(
      List<Category> categories, List<ProductModel> products) {
    print("buildSliverScrollView:: $products");
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        if (tabController != null) buildAppBar(categories),
        buildBody(categories, products),
      ],
    );
  }

  SliverAppBar buildAppBar(List<Category> categories) {
    return CustomAppBar(
      categories: categories,
      context: context,
      scrollController: scrollController,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      isCollapsed: Provider.of<DeliveryInfoProvider>(context).isCollapsed,
      onCollapsed: (value) =>
          Provider.of<DeliveryInfoProvider>(context, listen: false)
              .setCollapsed(value),
      tabController: tabController!,
      onTap: (index) => animateAndScrollTo(index),
    );
  }

  SliverList buildBody(List<Category> categories, List<ProductModel> products) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          final categoryProducts = filterProductsByCategory(products, category.id);
          print("buildBody:$categoryProducts");

          return buildCategoryItem(index, category, categoryProducts);
        },
        childCount: categories.length,
      ),
    );
  }

  Widget buildCategoryItem(
      int index, Category category, List<ProductModel> products) {
    itemKeys[index] = RectGetter.createGlobalKey();

    return RectGetter(
      key: itemKeys[index],
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: BodySection(
          categoryIndex: index,
          showGrid: index == 0,
          category: category,
          products: products,
        ),
      ),
    );
  }

  List<ProductModel> filterProductsByCategory(
      List<ProductModel> products, int categoryId) {
    return products
        .where((product) => product.category.id == categoryId)
        .toList();
  }
}
