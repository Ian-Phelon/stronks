import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/controller.dart';
import '../../../model/model.dart' show Performance;
import '../../widgets/widgets.dart';
import './extensions.dart';
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
        TotalPerformances(performanceCounts: performanceCounts),
        CalendarPerformancesScreen(
          performances: StatsHelper.performanceList,
        ),
      ]),
    );
  }
}

class TotalPerformances extends StatelessWidget {
  const TotalPerformances({
    Key? key,
    required this.performanceCounts,
  }) : super(key: key);

  final List<int> performanceCounts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Stats'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          TutorialBar(pageContext: 'stats'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainBannerAd(),
              Text(
                'Total Exercise Count: ${performanceCounts[0]
                // .performanceCounts[0]
                }',
                style: Theme.of(context).textTheme.headline5,
              ),
              Divider(
                color: Theme.of(context).colorScheme.onBackground,
                indent: 8.0,
                endIndent: 8.0,
              ),
              Text(
                'Arm Exercises: ${performanceCounts[1]}',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Chest Exercises: ${performanceCounts[2]}',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Back Exercises: ${performanceCounts[3]}',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Core Exercises: ${performanceCounts[4]}',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Leg Exercises: ${performanceCounts[5]}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          )
          //   ;
          // }),
        ],
      ),
    );
  }
}
