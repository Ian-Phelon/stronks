import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart';

Map<String, bool> _styles(BuildContext context, String? input) {
  return Provider.of<ExerciseRepository>(
    context,
    listen: false,
  ).eStyle(inputStyles: input == null || input == '' ? 'styles' : input);
}

Size _size(BuildContext context, String text) {
  text += '_____';
  return (TextPainter(
          text: TextSpan(text: text, style: kAspectTextStyle),
          maxLines: 1,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textDirection: TextDirection.ltr)
        ..layout())
      .size;
}

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({Key? key}) : super(key: key);

  @override
  _CreateExerciseScreenState createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  int? countForSets;
  StringBuffer? target;
  StringBuffer stylesStringBuilder = StringBuffer();
  StringBuffer? equips;
  late final Map<String, bool> styles =
      _styles(context, stylesStringBuilder.toString());

  @override
  void initState() {
    super.initState();
    setState(
      () {
        stylesStringBuilder.writeAll(_styles(
                super.context,
                stylesStringBuilder.length < 1
                    ? 'styles'
                    : stylesStringBuilder.toString())
            .entries
            .where((element) => element.value == true));
      },
    );
  }

  final TextEditingController txtCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TutorialBar tutorialBar = TutorialBar(
      pageContext: context,
    );

    return Scaffold(
      backgroundColor: colorExercisesBG,
      appBar: AppBar(
        title: Text('Create Exercise'),
      ),
      body: ListView(
        children: [
          tutorialBar,
          SizedBox(
            height: MediaQuery.of(context).size.height * .20,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: PurpleTextField(
                  keyboard: TextInputType.text,
                  onChanged: (value) => txtCtrl.text = value,
                  onSubmitted: (value) => txtCtrl.text = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 99,
                  child: ListView.builder(
                    // addAutomaticKeepAlives: true,

                    itemCount: styles.length,
                    // itemExtent: 200,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected = styles.entries.elementAt(index).value;
                      /////////
                      return Container(
                        height: _size(
                          context,
                          Provider.of<ExerciseRepository>(context)
                              .syleKeys[index],
                        ).height,
                        width: _size(
                          context,
                          Provider.of<ExerciseRepository>(context)
                              .syleKeys[index],
                        ).width,
                        child: haha(
                          // context: context,
                          isSelected: isSelected,
                          aspect: styles.entries.elementAt(index),
                          tapForSelection: () {
                            setState(() {
                              String newString =
                                  Provider.of<ExerciseRepository>(context,
                                          listen: false)
                                      .syleKeys
                                      .elementAt(index);
                              styles.update(newString, (value) => !isSelected);
                              newString += ', ';
                              stylesStringBuilder.write(
                                  stylesStringBuilder.toString() + newString);
                            });
                            print(stylesStringBuilder);
                            print(styles);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _pFAB(context, txtCtrl.text, countForSets, styles),
    );
  }

  @override
  void dispose() {
    this.txtCtrl.dispose();
    this.styles.clear();
    super.dispose();
  }
}

Widget _pFAB(
  BuildContext context,
  String text,
  int? countForSets,
  Map<String, bool> style,
) {
  final String styleString =
      Provider.of<ExerciseRepository>(context).eAspectToStringBuilder(style);
  final Map<String, dynamic> result = {
    'id': null,
    'name': '$text',
    'totalCount': 0,
    'countForSets': countForSets ?? 0,
    'style': styleString,
  };
  final repo = context.watch<ExerciseRepository>();
  return RoundTextButton(
    onPressed: () {
      repo.addToExerciseList(result);
      RoutePageManager.of(context).toExercises();
    },
    size: 42,
    text: 'Make It!',
    elevation: 4.0,
  );
}

Widget haha({
  // required BuildContext context,
  required MapEntry<String, bool> aspect,
  required VoidCallback tapForSelection,
  required bool isSelected,
}) {
  return AspectTile(
    // buildContext: context,
    aspect: aspect,
    tapForSelection: tapForSelection,
    isSelected: isSelected,
  );
}

Widget hehe({
  // required BuildContext context,
  required MapEntry aspect,
  required Map<String, bool> targets,
  required VoidCallback tapForSelection,
  required bool isSelected,
}) {
  return AspectTile(
    // buildContext: context,
    isTargets: targets,
    aspect: aspect,
    tapForSelection: tapForSelection,
    isSelected: isSelected,
  );
}
