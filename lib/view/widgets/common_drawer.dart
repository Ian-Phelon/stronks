import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// should also show RoutePageManager for removing ads
import '../../controller/controller.dart' show UserOptions; //,RoutePageManager;

// import '../../view/exercises/widgets/widgets.dart';

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
                inactiveThumbColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primaryVariant,
                inactiveTrackColor: Theme.of(context).colorScheme.background,
                activeColor: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primaryVariant,
                activeTrackColor: Theme.of(context).colorScheme.secondary,
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
                inactiveThumbColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Theme.of(context).colorScheme.background,
                activeColor: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.primaryVariant
                    : Theme.of(context).colorScheme.primaryVariant,
                activeTrackColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  'Use Metric Values',
                  style: Theme.of(context).textTheme.headline5,
                ),
                value: isUsesMetric,
                onChanged: (v) {
                  repo.toggleUsesMetric(v);
                },
              ),
              // Visibility(
              //   visible: true,

              //   // !Provider.of<UserOptions>(context, listen: false)
              //   //     .getOptionValue(userOptionsIndex: 2),
              //   child: Padding(
              //     padding: const EdgeInsets.all(18.0),
              //     child: StronksTextButton(
              //       text: 'Sign up/Remove Ads',
              //       onTap: () {
              //         RoutePageManager.of(context).toPurchases();
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      );
    });
  }
}
