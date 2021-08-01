import 'package:flutter/material.dart';
import '../../../controller/controller.dart';

import '../../widgets/widgets.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<int> performanceCounts =
        StatsHelper.of(context).getPerformances();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Stats'),
        ),
        body: Stack(
          children: [
            TutorialBar(pageContext: 'stats'),
            // Consumer<StatsHelper>(builder: (context, repo, _) {
            //   return
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
                MainBannerAd(),
              ],
            )
            //   ;
            // }),
          ],
        ),
      ),
    );
  }
}
