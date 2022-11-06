import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';

class UndoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UndoButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: undoActionColor,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)))),
          onPressed: onPressed,
          child: Text("UNDO"));
  }
}
