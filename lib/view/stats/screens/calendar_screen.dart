import 'package:flutter/material.dart';

import '../../../model/model.dart' show Performance;
import '../../widgets/widgets.dart';
import './day_tab.dart';
import './week_tab.dart';
import './month_tab.dart';

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
  late TabController _nestedTabCtrl;
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
