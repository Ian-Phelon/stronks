import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/controller.dart';
import '../../../model/model.dart' show Exercise, Performance;

import '../../widgets/widgets.dart';

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
        CalendarPerformances(
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

class CalendarPerformances extends StatefulWidget {
  const CalendarPerformances({
    Key? key,
    required this.performances,
  }) : super(key: key);

  final List<Performance> performances;
  @override
  _CalendarPerformancesState createState() => _CalendarPerformancesState();
}

class _CalendarPerformancesState extends State<CalendarPerformances>
    with TickerProviderStateMixin {
  /// wouldn't let me declare it as a tabcontroller
  var _nestedTabCtrl;
  Map<int, String> performanceIdToName = {};
  @override
  void initState() {
    _nestedTabCtrl = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Calendar'),
        actions: [
          IconButton(
              onPressed: () {
                // var p = Performance(
                //   id: null,
                //   datePerformed:
                //       DateTime.now().add(Duration(days: 4)).toString(),
                //   exerciseId: 2,
                //   updatedCount: 444,
                //   currentResistance: 0,
                //   currentTargets: '',
                //   repsOrHold: 0,
                //   splitMultiplier: 0,
                // );
                // var a = Performance(
                //   id: null,
                //   datePerformed:
                //       DateTime.now().add(Duration(days: 3)).toString(),
                //   exerciseId: 1,
                //   updatedCount: 111,
                //   currentResistance: 0,
                //   currentTargets: '',
                //   repsOrHold: 0,
                //   splitMultiplier: 0,
                // );
                // StatsHelper.of(context).addPerformance(p.toMap());
                // StatsHelper.of(context).addPerformance(a.toMap());
                print(swinger);
              },
              icon: Icon(Icons.menu))
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TabBar(
                controller: _nestedTabCtrl,
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.black54,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    text: 'Day',
                  ),
                  Tab(
                    text: 'Week',
                  ),
                  Tab(
                    text: 'Month',
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.3,
                child: TabBarView(
                  controller: _nestedTabCtrl,
                  children: [
                    CalendarDay(),
                    CalendarWeek(),
                    CalendarMonth(),
                  ],
                ),
              )
            ],
          ),
          TutorialBar(pageContext: 'statsCalendar'),
        ],
      ),
    );
  }
}

String exerciseIdToName(BuildContext context, int eId) {
  var eName;

  try {
    eName = Provider.of<ExerciseRepository>(context, listen: false)
        .getExercises()
        .singleWhere((e) => e.id == eId)
        .name;
  } catch (e) {
    return 'Deleted Exercise';
  }

  return eName ?? 'Deleted Exercise';
}

class CalendarDay extends StatelessWidget {
  const CalendarDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Performance> performances =
        StatsHelper.of(context).getPerformanceList().reversed.toList();
    return ListView.separated(
      itemBuilder: (context, index) {
        if (performances.isEmpty) {
          return Center(child: Text('You should do some exercise.'));
        }
        var performance = performances[index - 1 < 0 ? 0 : index - 1];
        if (index == 0) {
          var lastDatePerformed =
              DateTime.parse(performances[index].datePerformed!);
          return Text('${lastDatePerformed.month}/${lastDatePerformed.day}',
              style: Theme.of(context).textTheme.headline6);
        }
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            trailing: Text(performance.updatedCount!.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontStyle: FontStyle.italic)),
            tileColor: Theme.of(context).colorScheme.surface,
            title: Text('${exerciseIdToName(context, performance.exerciseId!)}',
                style: Theme.of(context).textTheme.headline5),
          ),
        );
      },
      separatorBuilder: (context, index) {
        var thisDt = DateTime.parse(performances[index].datePerformed!);

        var lastDt = DateTime.parse(
            performances[index - 1 < 0 ? 0 : index - 1].datePerformed!);
        if (thisDt.day != lastDt.day)
          return Text(
            '${thisDt.month}/${thisDt.day}',
            style: Theme.of(context).textTheme.headline6,
          );
        return const SizedBox.shrink();
      },
      itemCount: performances.length + 1,
    );
  }
}

late DateTime? swinger;

class CalendarWeek extends StatelessWidget {
  const CalendarWeek({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Performance> performances =
        StatsHelper.of(context).getPerformanceList().reversed.toList();

    return ListView.separated(
      itemBuilder: (context, index) {
        if (performances.isEmpty) {
          swinger = DateTime.now();
          return Center(child: Text('You should do some exercise.'));
        }
        var performance = performances[index - 1 < 0 ? 0 : index - 1];
        if (index == 0) {
          var lastDatePerformed =
              DateTime.parse(performances[index].datePerformed!);
          var weekDt = lastDatePerformed.subtract(Duration(days: 7));
          swinger = weekDt;
          return Text(
              '${lastDatePerformed.month}/${lastDatePerformed.day} - ${weekDt.month}/${weekDt.day}',
              style: Theme.of(context).textTheme.headline6);
        }
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            trailing: Text(performance.updatedCount!.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontStyle: FontStyle.italic)),
            tileColor: Theme.of(context).colorScheme.surface,
            title: Text('${exerciseIdToName(context, performance.exerciseId!)}',
                style: Theme.of(context).textTheme.headline5),
          ),
        );
      },
      separatorBuilder: (context, index) {
        var thisDt = DateTime.parse(performances[index].datePerformed!);
        var weekAgo = thisDt.subtract(Duration(days: 7));
        // DateTime.parse(
        //     performances[index - 7 < 0 ? 0 : index - 7].datePerformed!);
        if (weekAgo.day != thisDt.day)
          return Text(
            '${thisDt.month}/${thisDt.day} - ${weekAgo.month}/${weekAgo.day}',
            style: Theme.of(context).textTheme.headline6,
          );
        return const SizedBox.shrink();
      },
      itemCount: performances.length + 1,
    );
  }
}

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
