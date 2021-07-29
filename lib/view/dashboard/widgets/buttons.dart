import 'package:flutter/material.dart';

class DashButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;

  const DashButton({
    Key? key,
    @required this.onPressed,
    @required this.buttonText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
            side: BorderSide(
              width: 8,
              color: Theme.of(context).colorScheme.primary,
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Text(
              '$buttonText',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ),
    );
  }
}
