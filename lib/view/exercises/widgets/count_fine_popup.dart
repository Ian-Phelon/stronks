import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void CounterCallback(int value);
typedef bool SubtractCallback(bool value);

class CountFinePopup extends AlertDialog {
  const CountFinePopup({
    required this.onCounterChanged,
    this.titleText,
  });

  final CounterCallback onCounterChanged;
  final String? titleText;

  Widget addOrSubtract() => SizedBox.shrink();

  bool isTotalCount() => false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController numberTxt = TextEditingController();
    return AlertDialog(
      contentTextStyle: Theme.of(context).textTheme.headline4,
      titleTextStyle: Theme.of(context).textTheme.headline4,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(titleText ?? 'Oops'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: addOrSubtract(),
              ),
              isTotalCount()
                  ? SizedBox(
                      width: 29.0,
                    )
                  : SizedBox.shrink(),
              Container(
                width: 69,
                child: TextField(
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
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            num n = num.tryParse(numberTxt.text == '' ? '0' : numberTxt.text)!;

            onCounterChanged(n.toInt());
            numberTxt.dispose();
            Navigator.of(context).pop();
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}

class CountFinePopupSets extends CountFinePopup {
  CountFinePopupSets({required this.onCounterChanged})
      : super(
          onCounterChanged: onCounterChanged,
          titleText: 'How many Reps in a Set?',
        );
  final Function(int) onCounterChanged;
}

class CountFinePopupResistance extends CountFinePopup {
  CountFinePopupResistance({required this.onCounterChanged})
      : super(
          onCounterChanged: onCounterChanged,
          titleText: 'How much Resistance?',
        );
  final Function(int) onCounterChanged;
}

class CountFinePopupTotalCount extends CountFinePopup {
  CountFinePopupTotalCount({
    required this.onCounterChanged,
    required this.ok,
  }) : super(
          onCounterChanged: onCounterChanged,
          titleText: 'Update Total Count',
        );
  final Function(int) onCounterChanged;
  final bool Function(bool) ok;

  @override
  Widget addOrSubtract() {
    return Icon(Icons.add);

    ///fuckit
    // return AddOrSubtract(
    //   ok: ok,
    // );
  }

  @override
  bool isTotalCount() => true;
}

class AddOrSubtract extends StatefulWidget {
  const AddOrSubtract({
    Key? key,
    required this.ok,
  }) : super(key: key);
  final SubtractCallback ok;
  @override
  _AddOrSubtractState createState() => _AddOrSubtractState();
}

class _AddOrSubtractState extends State<AddOrSubtract> {
  Icon? icon;
  final Icon addIcon = Icon(Icons.add);
  final Icon subtractIcon = Icon(Icons.remove);

  /// plus == true, minus == false.
  late bool iconToggle;

  void changeIcon() {
    setState(() {
      iconToggle = !iconToggle;
    });
  }

  @override
  void initState() {
    super.initState();
    iconToggle = true;
  }

  bool getok() => !iconToggle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeIcon();
        widget.ok(getok());
      },
      child: iconToggle ? addIcon : subtractIcon,
    );
  }
}
