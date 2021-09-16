import 'dart:math';
import 'package:flutter/material.dart';
import '../../controller/controller.dart';
import './widgets/widgets.dart';
import '../widgets/widgets.dart' show TutorialBar, MainBannerAd, CommonDrawer;
import 'package:firebase_auth/firebase_auth.dart';

class FBAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      UserCredential ok = await _auth.signInAnonymously();
      User user = ok.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

const List<String> encouragement = [
  'Keep it Up!',
  'Let\'s Go!',
  'Pump Those Numbers Up!'
];

final rng = Random();
String encourage() => encouragement[rng.nextInt(encouragement.length)];
final String theEncouragement = encourage();

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // showDialog(
    //     barrierDismissible: true,
    //     context: context,
    //     builder: (context) {
    //       return Container(
    //         child: Material(
    //           child: Text('ok'),
    //         ),
    //       );
    //     });
    return SafeArea(
      child: Scaffold(
        drawer: CommonDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(theEncouragement),
        ),
        body: Stack(
          children: [
            TutorialBar(
              pageContext: 'dash',
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
                    FBAuth().signInAnon();
                    RoutePageManager.of(context).toStats();
                  },
                  buttonText: 'Stats',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainBannerAd(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
