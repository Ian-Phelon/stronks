import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../controller/controller.dart' show ExerciseRepository;
import '../../model/model.dart';

class TargetPanel extends StatefulWidget {
  final BuildContext? pageContext;
  // final Exercise exercise;
  final TargetPanelConfiguration? config;
  const TargetPanel({
    Key? key,
    @required this.pageContext,
    // @required this.exercise,
    this.config,
  }) : super(key: key);
  @override
  _TargetPanelState createState() => _TargetPanelState();
}

class _TargetPanelState extends State<TargetPanel> {
  // _TargetPanelState(this.exercise);
  // final Exercise exercise;
  // bool armsVisiblity;
  // bool chestVisibility;
  // bool backVisibility;
  // bool coreVisibility;
  // bool legsVisibility;

  //Arms arms = Arms();
  // List<Target> _addTargets(List<Target> targets)=>targets;
  @override
  Widget build(BuildContext context) {
    // final repoRead = context.read<ExerciseRepository>();
    // repoRead.selectExercise(exercise);
    // widget.config.
    // TargetPanelConfiguration config =
    //     TargetPanelConfiguration(widget.pageContext);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            width: 1.2,
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TargetButton(
                    title: 'Arms',
                    // target: widget.config?.arms,
                  ),
                  TargetButton(
                    title: 'Chest',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TargetButton(
                    title: 'Back',
                  ),
                  TargetButton(
                    title: 'Core',
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TargetButton(
                  title: 'Legs',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TargetButton extends StatelessWidget {
  const TargetButton({
    Key? key,
    @required this.title,
    // @required this.target,
    //  @required this.targetFineIsVisible,
  }) : super(key: key);

  final String? title;
  // final Target? target;
  //final bool targetFineIsVisible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ///  targetFineRow here
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 12,
                  right: 12,
                  child: Material(
                    color: Colors.white,
                    shape: ContinuousRectangleBorder(
                      side: BorderSide(
                        width: 4,
                        color: Colors.black,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'boooo', //target.runtimeType.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          textScaleFactor: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 6,
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.gps_fixed_outlined,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      color: Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 6,
                          color: Colors.black,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.check,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TargetPanelConfiguration {
  final BuildContext pageContext;
  // final Arms arms;
  // final Chest chest;
  // final Back back;
  // final Core core;
  // final Legs legs;
  // final List<Target> targets = [];

  TargetPanelConfiguration(
    this.pageContext,
    // this.arms,
    // this.chest,
    // this.back,
    // this.core,
    // this.legs,
  );
  void acquireTargets() {
    pageContext.visitAncestorElements((e) => e.runtimeType == Exercise);
  }
  // void addArms() => targets.add(Arms(
  //     targetInnerArm: true,
  //     targetOuterArm: true,
  //     targetLowerArm: true,
  //     targetUpperArm: true));
}
