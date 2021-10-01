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

  @override
  void initState() {
    performanceCounts = StatsHelper.of(context).getPerformanceCounts();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TabBarView(controller: _tabController, children: [
        TotalPerformances(
            performanceCounts: performanceCounts,
            tabController: _tabController),
        CalendarPerformancesScreen(
          performances: StatsHelper.performanceList,
          bottomTabBar: StatsBottomTabBar(tabController: _tabController),
        ),
      ]),
    );
  }
}

class TotalPerformances extends StatelessWidget {
  const TotalPerformances({
    Key? key,
    required this.performanceCounts,
    required this.tabController,
  }) : super(key: key);

  final List<int> performanceCounts;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Stats'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TotalsBody(
            performanceCounts: performanceCounts,
          ),
        ],
      ),
      bottomNavigationBar: StatsBottomTabBar(tabController: tabController),
    );
  }
}
