import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Common tab bar , using multiple places
class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> tabViews;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.tabViews,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            child: TabBar(
              indicatorColor: AppColors.primaryColor,
              indicatorWeight: 2,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.black,
              labelStyle: AppStyles().regularBolder,
              unselectedLabelStyle: AppStyles().regularSemiBold,
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: tabViews),
          ),
        ],
      ),
    );
  }
}
