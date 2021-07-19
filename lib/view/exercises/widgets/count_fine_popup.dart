import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets.dart';

typedef void CounterCallback(int value);
typedef void AsSetsCallback(bool value);

class CountFinePopup extends AlertDialog {
  const CountFinePopup({
    required this.onCounterChanged,
    this.titleText,
    this.countAsSets,
    this.addCountForSets,
  });

  final CounterCallback onCounterChanged;
  final AsSetsCallback? countAsSets;
  final String? titleText;
  final int? addCountForSets;

  Widget plusWidget() => SizedBox.shrink();
  bool isPlus() => false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController numberTxt = TextEditingController();
    bool isTotalCount = titleText == 'Total Count';
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
              plusWidget(),
              isPlus()
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

class CountFinePopupTotalCount extends CountFinePopup {
  CountFinePopupTotalCount({required this.onCounterChanged})
      : super(
          onCounterChanged: onCounterChanged,
          titleText: 'Update Total Count',
        );
  final Function(int) onCounterChanged;
  @override
  Widget plusWidget() => Icon(Icons.add);

  @override
  bool isPlus() => true;
}

class CountFinePopupResistance extends CountFinePopup {
  CountFinePopupResistance({required this.onCounterChanged})
      : super(
          onCounterChanged: onCounterChanged,
          titleText: 'How much Resistance?',
        );
  final Function(int) onCounterChanged;
}
