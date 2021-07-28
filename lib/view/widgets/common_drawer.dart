import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart' show RoutePageManager, UserOptions;
import '../../view/exercises/widgets/widgets.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserOptions>(builder: (_, repo, child) {
      bool isUsesDarkMode = repo.getOptionValue(userOptionsIndex: 0);
      bool isUsesMetric = repo.getOptionValue(userOptionsIndex: 1);
      return Drawer(
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SwitchListTile(
                title: Text(
                  'Use Dark Mode',
                  style: Theme.of(context).textTheme.headline5,
                ),
                value: isUsesDarkMode,
                onChanged: (v) {
                  repo.toggleUsesDarkMode(v);
                },
              ),
              SwitchListTile(
                title: Text(
                  'Use Metric Values',
                  style: Theme.of(context).textTheme.headline5,
                ),
                value: isUsesMetric,
                onChanged: (v) {
                  repo.toggleUsesMetric(v);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: StronksTextButton(
                  text: 'Remove Ads',
                  onTap: () {
                    // RoutePageManager.of(context).goToPurchases();
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
