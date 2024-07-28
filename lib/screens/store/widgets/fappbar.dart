import 'package:flutter/material.dart';
import 'package:foodstorefront/models/category_model.dart';
import 'package:foodstorefront/screens/store/widgets/delivery_info_widget.dart';
import 'package:foodstorefront/screens/store/widgets/discount_offtag_widgets.dart';
import 'package:foodstorefront/screens/store/widgets/more_info_text_widget.dart';
import 'package:foodstorefront/screens/store/widgets/see_reviews_widget.dart';
import 'package:foodstorefront/screens/store/widgets/store_namel_ogo_widget.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class FAppBar extends SliverAppBar {
  final List<Category> categories; // Change to List<Category>
  final BuildContext context;
  final bool isCollapsed;
  final double expandedHeight;
  final double collapsedHeight;
  final AutoScrollController scrollController;
  final TabController tabController;
  final void Function(bool isCollapsed) onCollapsed;
  final void Function(int index) onTap;

  FAppBar({
    required this.categories,
    required this.context,
    required this.isCollapsed,
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.scrollController,
    required this.onCollapsed,
    required this.onTap,
    required this.tabController,
  }) : super(
          backgroundColor: Colors.white,
          elevation: 0,
          pinned: true,
          forceElevated: true,
        );

  @override
  Widget? get leading => Container();

  @override
  PreferredSizeWidget? get bottom => PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: MyColors.white,
          child: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: tabController,
            // indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            indicatorColor: MyColors.primary,
            labelColor: MyColors.primary,
            unselectedLabelColor: MyColors.onsurface,
            indicatorWeight: 3.0,
            tabs: categories.map((category) {
              return Tab(text: category.name);
            }).toList(),
            onTap: onTap,
          ),
        ),
      );

  @override
  Widget? get flexibleSpace => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final top = constraints.constrainHeight();
          final collapsedHeight =
              MediaQuery.of(context).viewPadding.top + kToolbarHeight + 48;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            onCollapsed(collapsedHeight != top);
          });

          return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
              color: MyColors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    //store screen logo and name
                    StoreNameLogo(),
                    const SizedBox(height: 20),
                    const MoreInfo(),
                    const SizedBox(height: 15),
                    const SeeReviews(),
                    const SizedBox(height: 10),
                    const DeliveryInfo(),
                    const SizedBox(height: 15),
                    const AvailableDeals(),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
