import 'package:flutter/material.dart';
import '../../widgets/widgets.dart' show TutorialBar, MainBannerAd;

class TotalsBody extends StatelessWidget {
  const TotalsBody({
    Key? key,
    required this.performanceCounts,
  }) : super(key: key);

  final List<int> performanceCounts;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
      ],
    );
  }
}
