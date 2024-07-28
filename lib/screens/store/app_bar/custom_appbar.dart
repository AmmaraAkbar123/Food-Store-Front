import 'package:flutter/material.dart';
import 'package:foodstorefront/models/category_model.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/available_deal.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/delivery_info_widget.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/more_info_text_widget.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/see_reviews_widget.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/store_name_logo.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CustomAppBar extends SliverAppBar {
  final List<Category> categories; // Change to List<Category>
  final BuildContext context;
  final bool isCollapsed;
  final double expandedHeight;
  final double collapsedHeight;
  final AutoScrollController scrollController;
  final TabController tabController;
  final void Function(bool isCollapsed) onCollapsed;
  final void Function(int index) onTap;

  CustomAppBar({
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
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    //store screen logo and name
                    StoreNameLogo(),
                    SizedBox(height: 20),
                    MoreInfo(),
                    SizedBox(height: 15),
                    SeeReviews(),
                    SizedBox(height: 10),
                    DeliveryInfo(),
                    SizedBox(height: 15),
                    AvailableDeals(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
