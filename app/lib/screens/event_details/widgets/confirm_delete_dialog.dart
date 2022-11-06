import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmDeleteDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Event Deletion"),
      content: const Text("Are you sure you wish to delete the event?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text("Confirm")
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onCancel();
          },
          child: const Text("Cancel"))
      ]
    );
  }
}