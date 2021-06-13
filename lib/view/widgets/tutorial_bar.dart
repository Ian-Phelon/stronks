import 'package:flutter/material.dart';

/// Should be built on every screen. Takes the screen's build context
/// to pass on to `Tutorial` which provides the appropriate information.
class TutorialBar extends StatefulWidget {
  final BuildContext? pageContext;

  const TutorialBar({
    Key? key,
    @required this.pageContext,
  }) : super(key: key);

  @override
  _TutorialBarState createState() => _TutorialBarState();
}

class _TutorialBarState extends State<TutorialBar> {
  late bool isVisible;
  List<String>? tutorial;
  late int tutorialIndex;

  @override
  void initState() {
    super.initState();

    setState(() {
      isVisible = false;
      tutorial = _getTutorialStrings();
      tutorialIndex = 0;
    });
  }

  void triggerVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  double buttonOpacity(int indicator) {
    if (indicator.isNegative && tutorialIndex == 0) {
      return 0;
    }
    if (indicator.isOdd && tutorialIndex != tutorial!.length - 1) {
      return 0;
    } else {
      return 1;
    }
  }

  List<String> _getTutorialStrings() {
    Tutorial tutorial = Tutorial(pageContext: super.widget.pageContext);
    return tutorial.stringsFromContext();
  }

  void updateTutorialIndex(int indicator) {
    if (indicator == 1 && tutorialIndex < tutorial!.length - 1) {
      setState(() {
        tutorialIndex += indicator;
      });
    }
    if (indicator == -1 && tutorialIndex != 0) {
      setState(() {
        tutorialIndex += indicator;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            triggerVisibility();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.help_outline), //  my_location_sharp  all_out
          ),
        ),
      ),
      visible: isVisible,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Material(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Colors.black, width: 0.9),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  triggerVisibility();
                },
                child: Icon(Icons.close),
              ),
              Flexible(
                child: Text(
                  '${tutorial![tutorialIndex].trim()}',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: tutorialIndex == 0 ? 0.5 : 1,
                    child: GestureDetector(
                      // key: Key('minus'),
                      child: Icon(Icons.chevron_left),
                      onTap: () {
                        // buttonVisibility(widget.key);
                        updateTutorialIndex(-1);
                      },
                    ),
                  ),
                  Opacity(
                    opacity: tutorialIndex == tutorial!.length - 1 ? 0.5 : 1,
                    child: GestureDetector(
                      child: Icon(Icons.chevron_right),
                      onTap: () {
                        updateTutorialIndex(1);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Takes a pageContext as a constructor passed from the TutorialBar.
/// stringsFromContext() provides a List<String> based on context.
class Tutorial {
  /// uses the context of whichever page is on screen
  const Tutorial({@required this.pageContext});
  final BuildContext? pageContext;

  /// dashScreen
  static final List<String> dashboardScreen = const [
    //0
    '''
    Help is always here. Navigate tips by tapping the arrows to the right.
    
    ''',
    //1
    '''
    Tap Exercises to browse and edit the exercises you want to keep track of. 
    
    ''',
    //2
    '''
    Circuits are where you combine different exercises for a full workout.
    ''',
    //3
    '''
    Stats show overall progress.
    ''',
  ];

  ///E's screen
  static final List<String> exercisesScreen = const [
    ///0
    '''
    Tap the + button to add a new exercise. Any exercise you create will show up here.
    ''',

    ///1
    '''
    Tap an exercise to edit, and long press to get rid of an exercise. Deleting an exercise will not effect Stats.
    ''',
  ];

  /// CE screen
  static final List<String> createExerciseScreen = const [
    ///0
    '''
    Anything entered can be changed, or just hit Let's Go! and take care of it later.
    ''',

    ///1
    '''
    Name: Identify your exercise with a unique name.
    ''',

    ///2
    '''
    Location: Select one or more areas of the body that this exercise focuses on.
    ''',

    ///3
    '''
    Style: The type of exercise this is.
    ''',

    ///4
    '''
    Set: To make adding to your count easier, choose how many repetitions you want to do in a set.
    ''',
  ];

  /// EE screen
  static final List<String> editExerciseScreen = const [
    ///0
    '''
    Add to your total count by pressing the + buttons next to Count or Set. A Set adds your Set amount, and Count will bring up a number pad to enter in an exact amount.
    ''',

    ///1
    '''
    Tap any field to edit.
    ''',
  ];

  /// uses the context recieved from tutorial's constructor to provide a list of strings to be rendered by the `TutorialBar`
  List<String> stringsFromContext() {
    late final List<String> finalList;
    switch (this.pageContext?.widget.toString()) {
      case 'DashboardScreen':
        finalList = dashboardScreen;
        break;
      case 'ExercisesScreen':
        finalList = exercisesScreen;
        break;
      case 'CreateExerciseScreen':
        finalList = createExerciseScreen;
        break;
      case 'EditExerciseScreen':
        finalList = editExerciseScreen;
        break;
      default:
        finalList = ['errrrrrror $pageContext'];
    }
    return finalList;
  }
}
