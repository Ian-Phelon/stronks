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
    super.initState();
    _nestedTabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TabBar(
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
                ),
              ],
              controller: _nestedTabCtrl,
            ),
            MainBannerAd(),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
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
              ),
            ),
          ],
        ),
        TutorialBar(pageContext: 'statsCalendar'),
      ],
    );
  }
}
