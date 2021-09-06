import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/controller.dart';
import '../../../model/model.dart' show Exercise, Performance;

///devonly?
import 'dart:math';
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

class CalendarPerformancesScreen extends StatefulWidget {
  const CalendarPerformancesScreen({
    Key? key,
    required this.performances,
  }) : super(key: key);

  final List<Performance> performances;
  @override
  _CalendarPerformancesScreenState createState() =>
      _CalendarPerformancesScreenState();
}

class _CalendarPerformancesScreenState extends State<CalendarPerformancesScreen>
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
                ///playground
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
                    CalendarDay(
                      performances: widget.performances.reversed.toList(),
                    ),
                    CalendarWeek(
                      performances: widget.performances.reversed.toList(),
                    ),
                    CalendarMonth(
                      performances: widget.performances.reversed.toList(),
                    ),
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

class CalendarDay extends StatelessWidget {
  const CalendarDay({
    Key? key,
    required this.performances,
  }) : super(key: key);
  final List<Performance> performances;
  @override
  Widget build(BuildContext context) {
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
            title: Text(
                performance.exerciseId!.toString().exerciseIdToName(context),
                style: Theme.of(context).textTheme.headline5),
          ),
        );
      },
      separatorBuilder: (context, index) {
        var thisDt = performances[index].datePerformed!.parsePerformanceDate();
        var lastDt = performances[index.offsetOneBack()]
            .datePerformed!
            .parsePerformanceDate();
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

extension StatsDates on DateTime {
  String monthAndDay(bool usesMetric) =>
      usesMetric ? '${this.day}/${this.month}' : '${this.month}/${this.day}';
}

extension StatsInts on int {
  int offsetOneBack() => this - 1 < 0 ? 0 : this - 1;
  int offsetOneForward(int length) =>
      this + 1 >= length - 1 ? length - 1 : this + 1;
  Duration days() => Duration(days: this);
}

extension CalendarPerformances on String {
  DateTime parsePerformanceDate() => DateTime.parse(this);
  String exerciseIdToName(BuildContext context) {
    var exerciseName;

    try {
      exerciseName = Provider.of<ExerciseRepository>(context, listen: false)
          .getExercises()
          .singleWhere((e) => e.id == num.tryParse(this))
          .name;
    } catch (e) {
      return 'Deleted Exercise #${this}';
    }

    return exerciseName ?? 'Deleted Exercise';
  }
}

List<Map<int, int>> weekList = [];
List<DateTime> weekMarker = [];
void clearWeeks() {
  weekList.clear();
  weekMarker.clear();
}

void addAWeek() => weekList.add(Map<int, int>());
void updateWeek(int key, int count) =>
    weekList.last.update(key, (value) => value += count, ifAbsent: () => count);
DateTime targetDate() => weekMarker.last.subtract(8.days());

List<Map<int, int>> weeks(
    BuildContext context, List<Performance> performances) {
  clearWeeks();
  weekMarker.add(performances.first.datePerformed!.parsePerformanceDate());
  for (var index = 0; index < performances.length; index++) {
    var target = targetDate();
    var e = performances[index];
    var date = e.datePerformed!.parsePerformanceDate();
    var key = e.exerciseId!;
    var count = e.updatedCount!;

    if (weekList.length != weekMarker.length) addAWeek();
    if (date.isAfter(target)) updateWeek(key, count);
    if (date.isBefore(target)) weekMarker.add(date);
    if (weekList.length != weekMarker.length) {
      addAWeek();
      updateWeek(key, count);
    }
  }

  return weekList;
}

class CalendarWeek extends StatefulWidget {
  const CalendarWeek({
    Key? key,
    required this.performances,
  }) : super(key: key);
  final List<Performance> performances;

  @override
  _CalendarWeekState createState() => _CalendarWeekState();
}

class _CalendarWeekState extends State<CalendarWeek> {
  late DateTime lastPerformedDt;
  // late List<Map<int, int>> nameAndTotalByWeek;
  late final List<Map<int, int>> everyWeek;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    if (widget.performances.isEmpty) {
      lastPerformedDt = DateTime.now();
    } else {
      lastPerformedDt =
          widget.performances.first.datePerformed!.parsePerformanceDate();
      everyWeek = weeks(context, widget.performances);
    }
    super.initState();
  }

  Text weekForView(Iterable<int> exerciseIds, Iterable<int> counts) {
    StringBuffer namesAndCounts = StringBuffer();

    for (var i = 0; i < counts.length; i++) {
      namesAndCounts.write(
          exerciseIds.elementAt(i).toString().exerciseIdToName(context) +
              ': ' +
              counts.elementAt(i).toString());
      if (i < counts.length - 1) namesAndCounts.write('\n');
    }
    return Text(
      '$namesAndCounts',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (widget.performances.isEmpty) {
          return Center(child: Text('You should do some exercise.'));
        }
        if (index == 0) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            title: weekForView(everyWeek[index.offsetOneBack()].keys,
                everyWeek[index.offsetOneBack()].values),
            tileColor: Theme.of(context).colorScheme.surface,
          ),
        );
      },
      separatorBuilder: (context, index) {
        var weekStart = weekMarker[index];
        //.month.toString() +
        //     '/' +
        //     weekMarker[index].day.toString();

        var weekEnd = weekMarker[index].subtract(7.days());
        // var weekEnds = weekEnd.month.toString() + '/' + weekEnd.day.toString();

        return Text(
          '${weekStart.monthAndDay(UserOptions.of(context).getOptionValue(userOptionsIndex: 1))} - ${weekEnd.monthAndDay(UserOptions.of(context).getOptionValue(userOptionsIndex: 1))}',
          style: Theme.of(context).textTheme.headline6,
        );
      },
      itemCount: everyWeek.length + 1, //widget.performances.length + 1,
    );
  }
}

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({
    Key? key,
    required this.performances,
  }) : super(key: key);
  final List<Performance> performances;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
