import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/controller.dart';
import 'widgets/widgets.dart';
import '../widgets/widgets.dart' show TutorialBar, MainBannerAd;
import '../../constants.dart';

const List<String> encouragement = [
  'Keep it Up!',
  'Let\'s Go!',
  'Pump Those Numbers Up!'
];
bool _intToBool(BuildContext context, int v) =>
    Provider.of<UserOptions>(context, listen: false).intToBool(v);

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rng = Random();
    String encourage() => encouragement[rng.nextInt(encouragement.length)];

    ////////////////////////
    ////////////////////////
    ////////////////////////
    ////////////////////////
    /// Provider.of<UserOptions>(context,listen: false).
    ////////////////////////
    ////////////////////////
    ////////////////////////
    ////////////////////////

    return SafeArea(
      child: Scaffold(
        drawer: CommonDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(encourage()),
        ),
        body: Stack(
          children: [
            TutorialBar(
              pageContext: context,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DashButton(
                  onPressed: () {
                    RoutePageManager.of(context).toExercises();
                  },
                  buttonText: 'Exercises',
                ),
                DashButton(
                  onPressed: () {
                    RoutePageManager.of(context).toStats();
                  },
                  buttonText: 'Stats',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    MainBannerAd(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserOptions>(builder: (_, repo, child) {
      // repo.fetchAndSetUserOptionsTableData();

      bool darkModeOptionValue() =>
          repo.intToBool(repo.userOptions[0].optionValue!);
      bool ok = darkModeOptionValue();
      return Drawer(
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SwitchListTile(
                title: Text(
                  'Use Dark Mode',
                  style: Theme.of(context).textTheme.headline5,
                ),
                value: ok,
                onChanged: (v) {
                  repo.toggleUsesDarkMode(v);
                  print(repo.userOptions);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
