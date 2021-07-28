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

  /// positive 1 for next, negative 1 back
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
            child: Material(
              borderRadius: BorderRadius.circular(42 / 2.2),
              color: Theme.of(context).colorScheme.background,
              child: Icon(
                Icons.help_outline,
                size: 42,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            ),
          ),
        ),
      ),
      visible: isVisible,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 18.0,
          shadowColor: Theme.of(context).colorScheme.error,
          color: Theme.of(context).colorScheme.surface,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              color: Theme.of(context).colorScheme.primaryVariant,
              width: 2.9,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  triggerVisibility();
                },
                child: Icon(
                  Icons.close,
                  size: 35,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    '${tutorial![tutorialIndex].trim()}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: tutorialIndex == 0 ? 0.5 : 1,
                    child: GestureDetector(
                      child: Icon(
                        Icons.chevron_left,
                        size: 35,
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                      onTap: () {
                        updateTutorialIndex(-1);
                      },
                    ),
                  ),
                  Opacity(
                    opacity: tutorialIndex == tutorial!.length - 1 ? 0.5 : 1,
                    child: GestureDetector(
                      child: Icon(
                        Icons.chevron_right,
                        size: 35,
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
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
    Tap Exercises to add, browse, or edit the exercises you want to keep track of. 
    
    ''',
    //2
    '''
    Stats show a breakdown of your overall progress.
    ''',
  ];

  ///E's screen
  static final List<String> exercisesScreen = const [
    ///0
    '''
    Tap the + button at the bottom of the screen to add a new exercise. Any exercise you create will show up here.
    ''',

    ///1
    '''
    Each tile shows your Exercise's name, with the amount of times you have performed that exercise.
    ''',

    ///2
    '''
    Tap a tile to update the total count, or long press to edit other aspects such as your notes.
    ''',
  ];

  /// CE screen
  static final List<String> createExerciseScreen = const [
    ///0
    '''
    Anything entered can be changed later. By tapping "Make It!" at the bottom, you add this Exercise to your Exercise List. Going back will reset anything you've changed here and not add anything to the Exercise List. 
    ''',

    ///1
    '''
    Name: Identify your exercise with a unique name by tapping "Name It!".
    ''',

    ///2
    '''
    Targets: Select one or more areas of the body that this exercise focuses on. Selecting an area without specifying Inner, Outer, Upper, or Lower will target the whole area.
    ''',

    ///3
    '''
    Styles: The type of exercise this is.
    ''',

    ///4
    '''
    Equipment: If this exercise requires a particular type of equipment, make note of it here.
    ''',

    ///5
    '''
    Reps in a Set: Max Repetitions in a set.
    ''',

    ///6
    '''
    Resistance: How much weight, if any, is needed to perform this exercise.
    ''',

    ///7
    '''
    Notes: Your personal notepad for anything additional you would like to keep track of.
    ''',

    ///8
    '''
    Tap "Make It!" to add this Exercise to your Exercise List.
    ''',
  ];

  /// EE screen
  static final List<String> editExerciseScreen = const [
    ///0
    '''
    Everything that was set when you created this Exercise can be changed here, as well as update the total count for this Exercise.
    ''',

    ///1
    '''
    Tap the big number to update your total count.
    ''',

    ///2
    '''
    Notes are a great place to store a reminder for your next workout. 
    ''',

    ///3
    '''
    Update your amount of Resistance by tapping the number (or 'n/a' if left unset or 0).
    ''',

    ///4
    '''
    Update your amount of Max Repetitions by tapping the number (or 'n/a' if left unset or 0).
    ''',

    ///5
    '''
    Tap Targets, Style, or Equipment to select/deselect according to your needs.
    ''',

    ///6
    '''
    Change the name to more accurately describe your Exercise by tapping the icon to the left.
    ''',
  ];
  static final List<String> statsScreen = const [
    ///0
    '''
    This page is a representation of all the hard work you've put in to achieve your goals. Let's pump those numbers up!
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
      case 'StatsScreen':
        finalList = statsScreen;
        break;
      default:
        finalList = ['errrrrrror $pageContext'];
    }
    return finalList;
  }
}
