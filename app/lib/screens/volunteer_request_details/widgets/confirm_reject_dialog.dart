import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';

class ConfirmRejectDialog extends StatefulWidget {
  final Function(String?) onConfirm;
  final VoidCallback onCancel;
  final String volunteerName;

  const ConfirmRejectDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
    required this.volunteerName
  }) : super(key: key);

  @override
  _ConfirmRejectDialogState createState() => _ConfirmRejectDialogState();
}

class _ConfirmRejectDialogState extends State<ConfirmRejectDialog> {
  final _formKey = GlobalKey<FormState>();
  String? message;

  onValidateMessage(String? input) {
    return null;
  }

  onSaveMessage(String? input) {
    message = input;
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10.0),
      title: Text("Reject ${widget.volunteerName}"),
      content: Container(
        height: 130.0,
        width: 200.0,
        child: Form(
        key: _formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Message:", 
            style: boldTextStyle.copyWith(fontSize: 16.0)
          ),
          TextFormWidget(
            hintText: "Type here",
            maxLines: 4,
            maxLength: 256,
            onValidation: onValidateMessage,
            onSaved: onSaveMessage,
          )
        ],
      ))),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop();
              widget.onConfirm(message);
            }
          },
          child: const Text("Confirm")
        ),
        TextButton(
          onPressed: () {
            widget.onCancel();
            Navigator.of(context).pop();
          },
          child: const Text("Cancel")
        )
      ],
    );
  }
}