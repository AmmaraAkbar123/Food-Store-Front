import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar tabBar;

  CustomTabBar({required this.tabBar});

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TabBar(
              tabAlignment: TabAlignment.start,
              controller: tabBar.controller,
              isScrollable: tabBar.isScrollable,
              labelStyle: tabBar.labelStyle,
              labelPadding: EdgeInsets.symmetric(
                  horizontal: 8), // Adjust this padding as needed
              indicatorColor: tabBar.indicatorColor,
              labelColor: tabBar.labelColor,
              unselectedLabelColor: tabBar.unselectedLabelColor,
              tabs: tabBar.tabs.map((tab) {
                int index = tabBar.tabs.indexOf(tab);
                return Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: tab,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
