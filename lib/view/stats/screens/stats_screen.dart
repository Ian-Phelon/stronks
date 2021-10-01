import 'package:flutter/material.dart';
import '../../../controller/controller.dart';
import '../widgets/widgets.dart';
import './total_performances.dart';
import './calendar_screen.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final List<int> performanceCounts;
  late int titleTextIndex;
  void getTitleTextIndex() {
    setState(() {
      titleTextIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    performanceCounts = StatsHelper.of(context).getPerformanceCounts();
    _tabController = TabController(length: 2, vsync: this);
    titleTextIndex = 0;
    _tabController.addListener(getTitleTextIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  String _titleText(int? index) {
    if (index != 0) return 'Calendar';
    return 'Stats';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_titleText(titleTextIndex)),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TotalPerformances(
              performanceCounts: performanceCounts,
            ),
            CalendarPerformancesScreen(
              performances: StatsHelper.performanceList,
            ),
          ],
        ),
        bottomNavigationBar: StatsBottomTabBar(tabController: _tabController),
      ),
    );
  }
}
