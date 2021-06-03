import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../controller/controller.dart' show ExerciseRepository;
import '../../model/model.dart';

class TargetPanel extends StatefulWidget {
  final BuildContext? pageContext;
  final Exercise? exercise;
  const TargetPanel({
    Key? key,
    @required this.pageContext,
    this.exercise,
  }) : super(key: key);
  @override
  _TargetPanelState createState() => _TargetPanelState();
}

class _TargetPanelState extends State<TargetPanel> {
  // _TargetPanelState(this.exercise);
  // final Exercise exercise;
  late List<bool> armsTargeted;
  late List<bool> chestTargeted;
  late List<bool> backTargeted;
  late List<bool> coreTargeted;
  late List<bool> legsTargeted;

  @override
  void initState() {
    super.initState();
    _mapTargets();
  }

  void _mapTargets() {
    if (widget.exercise == null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // final repoRead = context.read<ExerciseRepository>();
    // repoRead.selectExercise(exercise);
    // widget.config.
    // TargetPanelConfiguration config =
    //     TargetPanelConfiguration(widget.pageContext);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TargetTile(
            title: 'Arms',
            // target: widget.config?.arms,
          ),
          TargetTile(
            title: 'Chest',
          ),
          TargetTile(
            title: 'Back',
          ),
          //  exercise = null ? TargetTile(
          //     title: 'Core'):TargetTile.withExercise(title: title, targetFine: targetFine);
          TargetTile(title: 'Core'),
          TargetTile(
            title: 'Legs',
          ),
        ],
      ),
    );
  }
}

class TargetTile extends StatefulWidget {
  const TargetTile({Key? key, @required this.title, this.targetFine})
      : super(key: key);

  final String? title;
  final List<bool>? targetFine;

  @override
  _TargetTileState createState() => _TargetTileState();
}

class _TargetTileState extends State<TargetTile> {
  late bool isTargeted;
  late bool? targetInner;
  late bool? targetOuter;
  late bool? targetUpper;
  late bool? targetLower;
  @override
  void initState() {
    super.initState();
    setState(() {
      ///
      isTargeted = false;
      // super.widget.targetFine == null
      //     ? targetInner = true
      //     : targetInner = super.widget.targetFine!.containsKey('targetInner');
    });
  }

  void _triggerVisibility() {
    setState(() {
      isTargeted = !isTargeted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 12,
            right: isTargeted == true ? 12 : null,
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  width: 4,
                  color: Colors.black,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 33,
                    ),
                    Text(
                      '${widget.title}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Visibility(
                      visible: isTargeted,
                      replacement: const SizedBox.shrink(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _targetFineIcon(Icons.gps_fixed, targetInner!),
                          _targetFineIcon(Icons.all_out, targetOuter!),
                          _targetFineIcon(
                              Icons.keyboard_arrow_up, targetUpper!),
                          _targetFineIcon(
                              Icons.keyboard_arrow_down, targetLower!),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                _triggerVisibility();
              },
              child: Material(
                shape: CircleBorder(
                  side: BorderSide(
                    width: 6,
                    color: Colors.black,
                  ),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Icon(
                    Icons.check,
                    size: 29,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _targetFineIcon(IconData iconData, bool isSelected) {
  bool selector = isSelected;
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: GestureDetector(
      onTap: () {
        selector = !selector;
      },
      child: Opacity(opacity: isSelected ? 1 : 0.5, child: Icon(iconData)),
    ),
  );
}
