import 'package:flutter/material.dart';

class StatsBottomTabBar extends StatelessWidget {
  const StatsBottomTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabBar(
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: 'Stats',
            ),
            Tab(
              text: 'Calendar',
            ),
          ],
          controller: tabController,
        ),
      ],
    );
  }
}
