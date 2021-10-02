import 'package:flutter/material.dart';

class StatsBottomTabBar extends StatelessWidget {
  const StatsBottomTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3.0,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            child: TabBar(
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
          ),
        ],
      ),
    );
  }
}
