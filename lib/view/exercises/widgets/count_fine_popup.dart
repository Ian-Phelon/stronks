import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void CounterCallback(int value);
typedef bool SubtractCallback(bool value);

class CountFinePopup extends AlertDialog {
  const CountFinePopup({
    required this.onCounterChanged,
    this.titleText,
    required this.exerciseName,
  });

  final CounterCallback onCounterChanged;
  final String? titleText;
  final String exerciseName;

  Widget addOrSubtract(BuildContext context) => SizedBox.shrink();

  bool isTotalCount() => false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController numberTxt = TextEditingController();
    return AlertDialog(
      contentTextStyle: Theme.of(context).textTheme.headline4,
      titleTextStyle: Theme.of(context).textTheme.headline5,
      backgroundColor: Theme.of(context).colorScheme.surface,
      // titlePadding: ,
      title: Text(titleText!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: addOrSubtract(context),
              ),
              isTotalCount()
                  ? SizedBox(
                      width: 29.0,
                    )
                  : SizedBox.shrink(),
              Container(
                width: 69,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    numberTxt.text = v;
                  },
                  onSubmitted: (v) => numberTxt.text = v,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            numberTxt.dispose();
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        TextButton(
          onPressed: () {
            num n = num.tryParse(numberTxt.text == '' ? '0' : numberTxt.text)!;

            onCounterChanged(n.toInt());
            numberTxt.dispose();
            Navigator.of(context).pop();
          },
          child: Text(
            'Update',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ],
    );
  }
}

class CountFinePopupSets extends CountFinePopup {
  CountFinePopupSets(
      {required this.onCounterChanged, required this.exerciseName})
      : super(
          exerciseName: exerciseName,
          onCounterChanged: onCounterChanged,
          titleText: 'How many Reps in a Set for "$exerciseName"?',
        );
  final Function(int) onCounterChanged;
  final String exerciseName;
}

class CountFinePopupResistance extends CountFinePopup {
  CountFinePopupResistance(
      {required this.onCounterChanged, required this.exerciseName})
      : super(
          exerciseName: exerciseName,
          onCounterChanged: onCounterChanged,
          titleText: 'How much Resistance for "$exerciseName"?',
        );
  final Function(int) onCounterChanged;
  final String exerciseName;
}

class CountFinePopupTotalCount extends CountFinePopup {
  CountFinePopupTotalCount({
    required this.onCounterChanged,
    required this.exerciseName,
  }) : super(
          exerciseName: exerciseName,
          onCounterChanged: onCounterChanged,
          titleText: 'Update Total Count for "$exerciseName"',
        );
  final Function(int) onCounterChanged;
  final String exerciseName;

  @override
  Widget addOrSubtract(BuildContext context) {
    return Icon(
      Icons.add,
      color: Theme.of(context).colorScheme.primaryVariant,
    );
  }

  @override
  bool isTotalCount() => true;
}

// class AddOrSubtract extends StatefulWidget {
//   const AddOrSubtract({
//     Key? key,
//     // required this.ok,
//   }) : super(key: key);
//   // final SubtractCallback ok;
//   @override
//   _AddOrSubtractState createState() => _AddOrSubtractState();
// }

// class _AddOrSubtractState extends State<AddOrSubtract> {
//   Icon? icon;

//   /// plus == true, minus == false.
//   late bool iconToggle;

//   void changeIcon() {
//     setState(() {
//       iconToggle = !iconToggle;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     iconToggle = true;
//   }

//   bool getok() => !iconToggle;
//   @override
//   Widget build(BuildContext context) {
//     final Icon addIcon = Icon(
//       Icons.add,
//       color: Theme.of(context).colorScheme.primaryVariant,
//     );
//     final Icon subtractIcon = Icon(
//       Icons.remove,
//       color: Theme.of(context).colorScheme.primaryVariant,
//     );
//     return GestureDetector(
//       onTap: () {
//         changeIcon();
//         widget.ok(getok());
//       },
//       child: iconToggle ? addIcon : subtractIcon,
//     );
//   }
// }
